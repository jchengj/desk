class Label < DeskApi
  GROUP = 2

  def self.query()
    data = get("labels")
    return [] if data.blank? || data["_embedded"].blank? || data["_embedded"]["entries"].blank?

    results = data["_embedded"]["entries"]
    results.map {|r| Filter.new(r) }
  end  
  
  def self.create(attributes)
    post("labels", attributes)
  end
end
