require 'alphavantage'
 
Alphavantage.configure do |config|
  config.api_key = Rails.application.credentials.alphavantage_client[:alpha_api_key]
end