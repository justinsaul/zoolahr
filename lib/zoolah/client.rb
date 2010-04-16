require 'oauth/consumer'

module Zoolah
  # If you haven't done so already register your application at https://ZoolahScribe.com/client_applications
  #
  # The full authorization process works like this over 2 controller actions (This example is in Rails):
  #
  #   def request_token
  #     @client = Zoolah::Client.new "key","secret"
  #     @request_token = @client.get_request_token
  #     
  #     # Store the token in a model in your applications mapping it to your user
  #     ZoolahRequestToken.create :user=>current_user,:token=>@request_token.token,:secret=>@request_token.secret
  #     redirect_to @request_token.authorize_url
  #   end
  #
  #   # The user authorizes the token on the Zoolah web site and is redirected to the authorize_url you setup when you registered your application at:
  #   # https://Zoolah.com/client_applications
  #   def authorize
  #     @client = Zoolah::Client.new "key","secret"
  #     
  #     # Load the request token from your ZoolahRequestToken through your user model
  #     @request_token = current_user.Zoolah_request_token.request_token
  #     
  #     # Exchange the authorized request token for a more permanent User token on the Zoolah site
  #     @user_client=@client.user_from_request_token(@request_token)
  #     
  #     # Store the Zoolah user data in your own model
  #     @Zoolah_user=ZoolahUser.create :user=>current_user,:token=>@user_client.token,:secret=>@user_client.secret
  #  end
  #
  
  class Client
    attr_accessor :consumer
    attr_accessor :site
    # Initialize the Zoolah Client
    #
    # === Required Fields
    #
    # * <tt>key</tt> - The Consumer Key
    # * <tt>secret</tt> - The Consumer Secret
    #
    # To get these register your application at: https://Zoolah.com/client_applications
    def initialize(key,secret,options={:site=>"https://zoolah.com"})
      @site = options[:site]
      @consumer=OAuth::Consumer.new(key,secret,options)
    end
    
    # initialize a new user object with the given token and secret. The user object is what you use to do most of the work.
    # Use this method when you need to create a user object from a token and secret you have stored in your applications database.
    #
    # === Required Fields
    #
    # * <tt>token</tt> - This is the authorized Token
    # * <tt>secret</tt> - This is the authorized Token Secret
    #
    def user(token,token_secret)
      User.new(self,token,token_secret)
    end
    
    # Start the process of authorizing a token for an Zoolah user.
    #
    # Example:
    #     @request_token = @client.get_request_token
    #     redirect_to @request_token.authorize_url
    #
    def get_request_token
      consumer.get_request_token
    end
    
    # Exchange an Authorized RequestToken for a working user object
    #
    # === Required Field
    # 
    # * <tt>request_token</tt> The Request token created using get_request_token and authorized on Zoolah by your user
    #
    # Example:
    #
    #     @user_client = @client.user_from_request_token(@request_token)
    #
    def user_from_request_token(request_token)
      access_token=request_token.get_access_token
      user(access_token.token,access_token.secret)
    rescue Net::HTTPServerException=>e
      if e.response.code=='401'
        raise ZoolahException,"The user has not authorized this request token",caller
      else
        raise
      end
    end

    # Returns your consumer key
    def key
      @consumer.key
    end
    
    # Returns your consumer secret
    def secret
      @consumer.secret
    end
    
    end
end