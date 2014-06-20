class Label < DeskApi
  attr_accessor :name, :description
  
  def self.query()
    @data = get("filters/labels")
    return [] if @data.blank? || @data["_embedded"].blank? || @data["_embedded"]["entries"].blank?

    @results = @data["_embedded"]["entries"]
    @results.map {|r| Label.new(r) }
  end  
end
