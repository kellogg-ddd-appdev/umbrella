task(:umbrella) do
  
  geocoding_url = "https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=REPLACE_THIS_QUERY_STRING_PARAMETER_WITH_YOUR_API_TOKEN"
  weather_url =  "https://api.darksky.net/forecast/26f63e92c5006b5c493906e7953da893/41.8887,-87.6355"
  # Get Google Maps geocoding data

  
  weather_raw_file = open(weather_url).read

  weather_parsed = JSON.parse(weather_raw_file)
  weather_c = weather_parsed.fetch("currently")
  weather_temp = weather_c.fetch("temperature")

  ap weather_temp


end