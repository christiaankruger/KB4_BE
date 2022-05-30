require_relative './spacex_api/spacex_api'
require_relative './find/find'

module SpaceXSearch
  BATCH_SIZE = 200

  def self.search(options)
    search_term = options[:search]

    puts "Searching for '#{search_term}'..."

    # Run every type of query on its own thread
    threads = SpaceXAPI::QUERIES.map do |query|
      Thread.new do
        data_hashes = []
        limit = BATCH_SIZE
        offset = 0

        loop do
          data = SpaceXAPI::Client.query(query, variables: { limit: limit, offset: offset }).original_hash['data']
          finder = Find.new(data)

          break if finder.items.empty?

          data_hashes.push(data)
          break if finder.items.length < BATCH_SIZE

          offset += BATCH_SIZE
        end

        all_results = data_hashes.map do |data|
          Find.new(data).find_term(search_term)
        end

        type = all_results.first[:type]
        ids = all_results.map { |result| result[:ids] }.flatten
        Thread.current[:output] = { type: type, ids: ids }
      end
    end

    all_results = threads.each_with_object([]) do |t, result|
      t.join
      result.push(t[:output])

      result
    end.each_with_object([]) do |result, memo|
      memo.push(result) unless result[:ids].empty?
    end

    puts "I have found '#{search_term}' in the following object types:"
    puts ''
    puts all_results
  end
end
