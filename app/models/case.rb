class Case
  include DeskApi
  
  def self.query(id)
    data = get("filters/#{id.to_i.to_s}/cases")
    return [] if data.blank? || data["_embedded"].blank? || data["_embedded"]["entries"].blank?

    results = data["_embedded"]["entries"]
    results.map {|r| Case.new(r) }
  end
  
  def self.update(id, attributes)
    patch("cases/#{id.to_i.to_s}", attributes)
  end
end
