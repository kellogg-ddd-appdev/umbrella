task(:umbrella) do

  user_location = "Merchandise Mart Chicago"
  user_latlong = "41.8887,-87.6355"

  geocoding_api_key = ENV.fetch("GEOCODING_API_KEY")
  darksky_api_key = ENV.fetch("DARKSKY_API_KEY")

  geocoding_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + geocoding_api_key

  ## Get Google Maps geocoding data
  address_raw_file = open(geocoding_url).read
  address_parsed = JSON.parse(address_raw_file)
  results_array = address_parsed.fetch("results")
  results_hash = results_array[0]
  results_geometry = results_hash.fetch("geometry")
  results_location = results_geometry.fetch("location")
  user_lat = results_location.fetch("lat")
  user_long = results_location.fetch("lng")
  user_latlong = user_lat.to_s + "," + user_long.to_s

  ## Get Dark Sky data
  weather_url =  "https://api.darksky.net/forecast/" + darksky_api_key + "/" + user_latlong

  weather_raw_file = open(weather_url).read

  weather_parsed = JSON.parse(weather_raw_file)
  weather_c = weather_parsed.fetch("currently")
  weather_temp = weather_c.fetch("temperature")

  ap weather_temp


end