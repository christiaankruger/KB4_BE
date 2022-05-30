require_relative './spacex_api/spacex_api'

module SpaceXSearch
  def self.search(options)
    search_term = options[:search]

    data = SpaceXAPI::Client.query(SpaceXAPI::DragonsQuery, variables: {limit: 0, offset: 0})
    p data
  end
end

# [:description, :name, :details]