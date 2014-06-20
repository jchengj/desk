class DeskApi  
  class ApiHttpError < StandardError; end
  
  HEADERS = { 'Accept'=>'application/xml', 'Content-Type' => 'application/xml' }
  SUCCESS_STATUSES = [200, 201, 202, 204]
  
  ##########################################################################
  #
  # Constructor that takes a hash and build instance variables for each 
  # key value pair
  #
  ##########################################################################
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  ##########################################################################
  #
  # Build the prefix for the request url
  # returns a partial url string
  # example : https://joseph.desk.com/api/v2/
  #
  ##########################################################################
  
  def self.prefix
    "#{DESK[:site]}/api/v#{DESK[:version]}/"
  end
  
  
  ##########################################################################
  #
  # wrapper method for oauth get
  # receives a path less the prefix
  # returns a hash of the response body
  #
  # Exceptions:
  # ApiHttpError is raised if response status is not 200
  #
  ###########################################################################
  def self.get(path)
    resp = token.get(prefix + path, HEADERS)
    
    raise ApiHttpError resp.code unless SUCCESS_STATUSES.include? resp.code.to_i
    JSON.parse(resp.body)
  end

  ##########################################################################
  #
  # wrapper method for oauth post, altering its http method to PATCH in header
  # receives a string path less the prefix and a hash object
  #
  # Exceptions:
  # ApiHttpError is raised if response status is not 200
  #
  ###########################################################################  
  
  def self.patch(path, attr)
    raise ApiHttpError "nothing" if attr.blank?  
    resp = token.post(prefix + path, attr.to_json, HEADERS.merge! {"x-http-method-override" => "PATCH"})
    
    raise ApiHttpError resp.code unless SUCCESS_STATUSES.include? resp.code.to_i
    JSON.parse(resp.body)
  end
  
  ##########################################################################
  #
  # wrapper method for oauth post
  # receives a string path less the prefix and a hash object
  #
  # Exceptions:
  # ApiHttpError is raised if response status is not 200
  #
  ###########################################################################  
  def self.post(path, attr)
    token.post(prefix + path, attr, HEADERS) 
    resp = token.post(prefix + path, attr.to_json, HEADERS) 
    
    raise ApiHttpError resp.code unless SUCCESS_STATUSES.include? resp.code.to_i
    JSON.parse(resp.body) 
  end
  
  ##########################################################################
  #
  # Build the access Token that is used for the actual web service calls
  # retrieve credentials from config/desk.yml
  # returns a OAuth::AccessToken object
  #
  ##########################################################################
  
  def self.token
      consumer  = OAuth::Consumer.new(
                          DESK[:api_key],
                          DESK[:api_secret],
                          :site => DESK[:site],
                          :scheme => :header)

      return OAuth::AccessToken.from_hash(
        consumer,
        :oauth_token => DESK[:access_token],
        :oauth_token_secret => DESK[:access_token_secret])
  end
end