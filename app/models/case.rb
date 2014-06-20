class Case < DeskApi
  attr_accessor :id, :subject, :status, :type, :labels, :label_ids
  
  def self.query(id)
    data = get("filters/#{id.to_i.to_s}/cases")
    return [] if data.blank? || data["_embedded"].blank? || data["_embedded"]["entries"].blank?

    results = data["_embedded"]["entries"]
    results.map {|r| Case.new(r) }
  end
  
  def self.update(id, attr)
    patch("/cases/#{id.to_i.to_s}/", attr)
  end
end
