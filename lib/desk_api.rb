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
  
  ##########################################################################
  #
  # dynamically create all setter methods based on the hash keys stored in @data
  #
  ##########################################################################  
  
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
    # Decorator method to properly format the json returned from the api call
    # if the call succeeded (20x)
    #   it will return true, and intialize either the a single object or an 
    #   array of objects
    #
    # if the call failed
    #   an ApiError will be raised with the message 
    #
    ##########################################################################    
    
    def request(method, *options)
      
      resp = send(method, *options)
      body = JSON.parse(resp.body)
      success = SUCCESS_STATUSES.include? resp.code.to_i
      
      raise ApiError.new body["message"] unless success
          
      if body["_embedded"] && body["_embedded"]["entries"]
        body =  body["_embedded"]["entries"].map{|d| self.new(d) } 
      else
        body = self.new(body)
      end
      
      return body
    end
    
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
    end

    ##########################################################################
    #
    # wrapper method for oauth post, altering its http method to PATCH in header
    # receives a string path less the prefix and a hash object
    #
    ###########################################################################  
  
    def patch(path, attributes)
      resp = token.post(prefix + path, attributes.to_json, HEADERS.merge({"x-http-method-override" => "PATCH"}))
    end
  
    ##########################################################################
    #
    # wrapper method for oauth post
    # receives a string path less the prefix and a hash object
    #
    ###########################################################################  
    def post(path, attributes)
      resp = token.post(prefix + path, attributes.to_json, HEADERS)
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