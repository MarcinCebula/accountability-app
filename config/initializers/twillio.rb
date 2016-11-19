require 'rubygems'
require 'twilio-ruby'

# put your own credentials here


Twilio.configure do |config|
  config.account_sid = ENV["TWILLIO_ACCOUNT_SID"]
  config.auth_token = ENV["TWILLIO_AUTH_TOKEN"]
end

@twillio = Twilio::REST::Client.new
