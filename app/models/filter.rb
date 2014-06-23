class Filter
  include DeskApi
  
  def id
    @data["_links"]["self"]["href"][/\d+$/]
  end
  
  def self.query()
    request(:get, "filters")
  end
end
