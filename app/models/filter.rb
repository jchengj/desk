class Filter
  include DeskApi
  
  def id
    @data["_links"]["self"]["href"][/\d+$/]
  end
  
  def self.query()
    data = get("filters")
    return [] if data.blank? || data["_embedded"].blank? || data["_embedded"]["entries"].blank?

    results = data["_embedded"]["entries"]
    results.map {|r| Filter.new(r) }
  end
end
