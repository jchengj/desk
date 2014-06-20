class User < DeskApi
  attr_accessor :id, :name, :avatar
  
  def self.current_user
    data = get("users/current_user") || {}
    new User(data)
  end
end