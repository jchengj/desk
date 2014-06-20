class User < DeskApi
  
  def self.current_user
    data = get("users/current_user") || {}
    new User(data)
  end
end