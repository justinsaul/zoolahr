require 'net/https'
require 'rubygems'
gem 'oauth'
require 'oauth'
gem 'json'
gem 'activesupport'
require 'activesupport'


module Zoolah
  class ZoolahException < RuntimeError #:nodoc:
  end
end

require File.join(File.dirname(__FILE__), 'zoolah', 'base')
require File.join(File.dirname(__FILE__), 'zoolah', 'client')
require File.join(File.dirname(__FILE__), 'zoolah', 'user')


# FireEagle addition to the <code>OAuth::Consumer</code> class. Taken from Yahoo FireEagle GEM
class OAuth::Consumer
  alias_method :create_http_with_verify, :create_http
  # Monkey patch to silence the SSL warnings
  def create_http_without_verify #:nodoc:
    http_object             = create_http_with_verify
    http_object.verify_mode = OpenSSL::SSL::VERIFY_NONE if uri.scheme=="https"
    http_object
  end
  alias_method :create_http, :create_http_without_verify
end
