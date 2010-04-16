class ZoolahToken < ConsumerToken
  MY_SERVICE_SETTINGS={:site=>"https://zoolah.com"}
  
  # override self.consumer so we don't have to specify url's in options
  def self.consumer
    @consumer||=OAuth::Consumer.new credentials[:key],credentials[:secret],MY_SERVICE_SETTINGS
  end
  
  def self.zoolah_client
    @zoolah_client||=Zoolah::Client.new credentials[:key],credentials[:secret],MY_SERVICE_SETTINGS
  end
  # overide client to return a high level client object
  def client
    @client||=Zoolah::Client.new( ZoolahToken.consumer.key,ZoolahToken.consumer.secret,MY_SERVICE_SETTINGS)
  end
  
  def zoolah_user
    client.user self.token, self.secret
  end
  #gather user's info
  def get_user_info
    JSON.parse(zoolah_user.get_user_info)
  end
  
  #get the user's subscriptions to a specific vendor (you)
  def user_vendor_subscriptions
    JSON.parse(zoolah_user.user_vendor_subscriptions)
  end
  
  #is the user the owner of the client application?
  def is_user_owner_client_app
    JSON.parse(zoolah_user.is_user_owner_client_app)
  end
  
  def debit_user_once(amount=0, return_url="")
    data = {"amount"=>amount, "return_url"=>return_url}.to_json
    result = zoolah_user.debit_user(data)
    if response.class == String
      result = JSON.parse(response)
    else
      result = JSON.parse(response.body)
    end    
    if result["error"]
      #raise Zoolah::ZoolahException.new(result["error"])
      return {:request_link => result["url"], :code => result["code"]}
    else
      return result["purchase_id"]
    end
  end
  
  def debit_user(amount=0)
    data = {"amount"=>amount}.to_json
    response = zoolah_user.debit_user(data)
    if response.class == String
      result = JSON.parse(response)
    else
      result = JSON.parse(response.body)
    end
    if result["error"]
      #raise Zoolah::ZoolahException.new(result["error"])
      return {:request_link=>result["request_link"]}
    else
      return result["purchase_id"]
    end
  end
  
  def credit_user(amount=0)
    data = {"amount"=>amount}.to_json
    response = zoolah_user.debit_user(data)
    if response.class == String
      result = JSON.parse(response)
    else
      result = JSON.parse(response.body)
    end
    if result["error"]
      raise Zoolah::ZoolahException.new(result["error"])
    else
      return result["purchase_id"]
    end
  end
  
  def refund_user(purchase_id=nil, amount=nil)
    data = {"purchase_id"=>purchase_id, "refund_amount"=>amount}.to_json
    result = zoolah_user.refund_user(data)
    if response.class == String
      result = JSON.parse(response)
    else
      result = JSON.parse(response.body)
    end    
    if result["error"]
      raise Zoolah::ZoolahException.new(result["error"])
    else
      return result["refund_id"]
    end    
  end
  
  def view_invoice(invoice=0)
    response = zoolah_user.view_invoice(invoice)
    if response.class == String
      result = JSON.parse(response)
    else
      result = JSON.parse(response.body)
    end
    if result["error"]
      raise Zoolah::ZoolahException.new(result["error"])
    else
      return result
    end    
  end
  
  def request_zoolah_purchase(amount=0)
    data = {"amount"=>amount}.to_json
    response = zoolah_user.request_zoolah_purchase(data)
    if response.class == String
      result = JSON.parse(response)
    else
      result = JSON.parse(response.body)
    end
    if result["error"]
      raise Zoolah::ZoolahException.new(result["error"])
    else
      return result["request_key"]
    end     
  end
  
  def authorize_zoolah_purchase(request_key=nil, code=nil)
    data = {"request_key"=>request_key, "code"=>code}.to_json
    response = zoolah_user.authorize_zoolah_purchase(data)
    if response.class == String
      result = JSON.parse(response)
    else
      result = JSON.parse(response.body)
    end
    if result["error"]
      raise Zoolah::ZoolahException.new(result["error"])
    else
      return true
    end    
  end
  
  def request_debit_increase
    JSON.parse(zoolah_user.request_debit_increase)     
  end
  
  def authorize_debit_increase(pin=0, amount=0)
    data = {"pin"=>pin, "amount"=>amount}.to_json
    response = zoolah_user.authorize_debit_increase(data)
    if response.class == String
      result = JSON.parse(response)
    else
      result = JSON.parse(response.body)
    end
    if result["error"]
      raise Zoolah::ZoolahException.new(result["error"])
    else
      return result["success"]
    end    
  end
  
  def purchase_subscription(offer_token=nil)
    data = {"offer_token"=>offer_token}.to_json
    response = zoolah_user.purchase_subscription(data)
    if response.class == String
      result = JSON.parse(response)
    else
      result = JSON.parse(response.body)
    end
    if result["error"]
      raise Zoolah::ZoolahException.new(result["error"])
    else
      return result
    end      
  end
  
  def cancel_subscription(subscription_id=nil)
    data = {"subscription_id"=>subscription_id}.to_json
    response = zoolah_user.purchase_subscription(data)
    if response.class == String
      result = JSON.parse(response)
    else
      result = JSON.parse(response.body)
    end
    if result["error"]
      raise Zoolah::ZoolahException.new(result["error"])
    else
      return result
    end    
  end
end