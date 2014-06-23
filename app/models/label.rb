class Label
  include DeskApi
  
  GROUP = 3
  PARAM = ["name", "description"]

  def self.query()
    request(:get, "labels")
  end  
  
  def self.create(attributes)
    request(:post, "labels", attributes)
  end
end
