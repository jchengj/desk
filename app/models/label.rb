class Label < DeskApi
  def self.query()
    get("labels")
  end  
  
  def self.create(attributes)
    post("labels", attributes)
  end
end