class User
  include DeskApi
  
  def self.current_user
    data = get("users/current") || {}
    User.new(data)
  end
end