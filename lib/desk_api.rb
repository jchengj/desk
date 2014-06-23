module DeskApi
  extend ActiveSupport::Concern
  
  ##########################################################################
  #
  # Constructor that takes a hash and build instance variables for each 
  # key value pair
  #
  ##########################################################################
  
  def initialize(attributes = {})
    @data = attributes
  end
  
  def method_missing(method_sym, *arguments, &block)
    if arguments.blank? || block.blank?
      @data[method_sym.to_s]
    else
      super
    end
  end
  
  module ClassMethods
    HEADERS = { 'Accept'=>'application/json', 'Content-Type' => 'application/json' }
    SUCCESS_STATUSES = [200, 201, 202, 204]
    
    ##########################################################################
    #
    # Build the prefix for the request url
    # returns a partial url string
    # example : https://joseph.desk.com/api/v2/
    #
    ##########################################################################
  
    def prefix
      "#{DESK[:site]}/api/v#{DESK[:version]}/"
    end
  
    ##########################################################################
    #
    # wrapper method for oauth get
    # receives a path less the prefix
    # returns a hash of the response body
    #
    ###########################################################################
    def get(path)
      resp = token.get(prefix + path, HEADERS)
    
      return false unless SUCCESS_STATUSES.include? resp.code.to_i
      JSON.parse(resp.body)
    end

    ##########################################################################
    #
    # wrapper method for oauth post, altering its http method to PATCH in header
    # receives a string path less the prefix and a hash object
    #
    ###########################################################################  
  
    def patch(path, attributes)
      resp = token.post(prefix + path, attributes.to_json, HEADERS.merge!({"x-http-method-override" => "PATCH"}))
    
      return false unless SUCCESS_STATUSES.include? resp.code.to_i
      JSON.parse(resp.body)
    end
  
    ##########################################################################
    #
    # wrapper method for oauth post
    # receives a string path less the prefix and a hash object
    #
    ###########################################################################  
    def post(path, attributes)
      token.post(prefix + path, attr, HEADERS) 
      resp = token.post(prefix + path, attributes.to_json, HEADERS) 
    
      return false unless SUCCESS_STATUSES.include? resp.code.to_i
      JSON.parse(resp.body) 
    end
  
    ##########################################################################
    #
    # Build the access Token that is used for the actual web service calls
    # retrieve credentials from config/desk.yml
    # returns a OAuth::AccessToken object
    #
    ##########################################################################
  
    def token
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
end