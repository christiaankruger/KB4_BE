class Find
  def initialize(data)
    @data = data
  end

  def find_term(search_term)
    downcased_search_term = search_term.downcase
    ids = items.select do |item|
      (item.keys - ['id']).any? do |key|
        next false unless item[key]

        text = item[key].downcase
        text.include?(downcased_search_term)
      end
    end.map do |item|
      item['id']
    end

    {
      type: node_key,
      ids: ids
    }
  end

  def items
    @items ||= @data[node_key] || []
  end

  private

  def node_key
    @node_key ||= @data.keys.first
  end
end
