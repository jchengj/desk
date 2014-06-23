class Case
  include DeskApi
  
  def self.query(id)
    request(:get, "filters/#{id.to_i.to_s}/cases")
  end
  
  def self.update(id, attributes)
    request(:patch, "cases/#{id.to_i.to_s}", attributes)
  end
end
