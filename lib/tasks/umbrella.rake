task(:umbrella) do

  user_location = "Merchandise Mart Chicago"
  user_latlong = "41.8887,-87.6355"

  geocoding_api_key = ENV.fetch("GEOCODING_API_KEY")
  darksky_api_key = ENV.fetch("DARKSKY_API_KEY")

  geocoding_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + geocoding_api_key
  weather_url =  "https://api.darksky.net/forecast/" + darksky_api_key + "/" + user_latlong

  # Get Google Maps geocoding data
  # address_raw_file = open(geocoding_url).read
  # address_parsed = JSON.parse(address_raw_file)

  # Get Dark Sky data
  weather_raw_file = open(weather_url).read

  weather_parsed = JSON.parse(weather_raw_file)
  weather_c = weather_parsed.fetch("currently")
  weather_temp = weather_c.fetch("temperature")

  ap weather_temp


end