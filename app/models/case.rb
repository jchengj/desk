class Case < DeskApi
  def self.query(id)
    get("filters/#{id.to_i.to_s}/cases")
  end
  
  def self.update(id, attributes)
    patch("cases/#{id.to_i.to_s}", attributes)
  end
end
