class User
  include DeskApi
  
  def self.current_user
    request(:get, "users/current")
  end
end