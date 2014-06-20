class Filter < DeskApi
  attr_accessor :name
  
  def self.query()
    @data = get("filters")
    return [] if @data.blank? || @data["_embedded"].blank? || @data["_embedded"]["entries"].blank?

    @results = @data["_embedded"]["entries"]
    @results.map {|r| Filter.new(r) }
  end
end
