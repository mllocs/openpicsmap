# config/initializers/geocoder.rb
Geocoder.configure do |config|

  # geocoding service (see below for supported options):
  config.lookup = :google

  # to use an API key:
  #config.api_key = "..."

  # geocoding service request timeout, in seconds (default 3):
  config.timeout = 15 

  # set default units to kilometers:
  config.units = :km

end