ZOOLAH_JSON_HEADERS={'Content-Type'=>'application/json','Accept'=>'application/json'}
module Zoolah
  class User
    attr_accessor :client,:access_token
    def initialize(client,key,secret)
      @client=client
      @access_token=OAuth::AccessToken.new @client.consumer,key,secret
    end
    
    def get(path)
      handle_response @access_token.get(path,ZOOLAH_JSON_HEADERS)
    end

    def head(path)
      handle_response @access_token.head(path,ZOOLAH_JSON_HEADERS)
    end
    
    def post(path,data=nil)
      handle_response @access_token.post(path,(data ? data.to_json : nil),ZOOLAH_JSON_HEADERS)
    end
    
    def put(path,data=nil)
      handle_response @access_token.put(path,(data ? data.to_json : nil),ZOOLAH_JSON_HEADERS )
    end
    
    def delete(path)
      handle_response @access_token.delete(path,ZOOLAH_JSON_HEADERS)
    end

    # OAuth Stuff below here
    
    # The AccessToken token
    def token
      @access_token.token
    end
    
    # The AccessToken secret
    def secret
      @access_token.secret
    end
    
    def path #:nodoc:
      ""
    end
    
    #### COMMON CALLS ####
    #gather user's info
    def get_user_info
      get("/api/v1/oauth_user_info.json")
    end
  
    #get the user's subscriptions to a specific vendor (you)
    def user_vendor_subscriptions
      get("/api/v1/oauth_user_vendor_subscriptions.json")
    end
  
    #is the user the owner of the client application?
    def is_user_owner_client_app
      get("/api/v1/oauth_is_user_owner_client_app.json")
    end
    
    ### TO BE MOVED INTO NEW CLASS ###
    
    def debit_user_once(data)
      post("/api/v1/oauth_debit_user_once.json", data)
    end
    
    def debit_user(data)
      post("/api/v1/oauth_debit_user.json", data)
    end
    
    def credit_user(data)
      post("/api/v1/oauth_credit_user.json", data)
    end
    
    def refund_user(data)
      post("/api/v1/oauth_refund_user.json", data)
    end
    
    def view_invoice(data)
      get("/api/v1/oauth_view_invoice.json?invoice_id=#{data}")
    end
    
    def request_zoolah_purchase(data)
      post("/api/v1/oauth_request_zoolah_purchase.json", data)
    end
    
    def authorize_zoolah_purchase(data)
      post("/api/v1/oauth_authorize_zoolah_purchase.json", data)
    end
    
    def request_debit_increase
      get("/api/v1/oauth_request_debit_increase.json")
    end
    
    def authorize_debit_increase(data)
      post("/api/v1/oauth_authorize_debit_increase.json", data)
    end
    
    def purchase_subscription(data)
      post("/api/v1/oauth_purchase_subscription.json", data)
    end
    
    def cancel_subscription(data)
      post("/api/v1/oauth_cancel_subscription.json", data)
    end
    
    protected
    
    def handle_response(response)#:nodoc:
      case response.code
      when "200"
        response.body
      when "201"
        response.body
      when "302"
        if response['Location']=~/(#{@client.site})\/(.*)$/
          parts=$2.split('/')
          (('Zoolah::'+parts[0].classify).constantize).get self,parts[1]
        else
          #todo raise hell
        end
      else
        response
      end
    end
  end
end