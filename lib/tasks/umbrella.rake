task(:umbrella) do

  p "Enter a location"
  user_location = STDIN.gets.chomp
  
  # user_latlong = "41.8887,-87.6355" Used for testing

  geocoding_api_key = ENV.fetch("GEOCODING_API_KEY")
  darksky_api_key = ENV.fetch("DARKSKY_API_KEY")

  geocoding_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + geocoding_api_key

  ## Get Google Maps geocoding data
  address_raw_file = open(geocoding_url).read
  address_parsed = JSON.parse(address_raw_file)
  address_status = address_parsed.fetch("status")
  if address_status != "OK"
    p "Location not found"
    else
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

      weather_c = weather_parsed.fetch("currently", {"temperature" => "", "summary" => ""})
        weather_temp = weather_c.fetch("temperature")
        weather_currenttemp = weather_temp.round(0)
        weather_currentweather = weather_c.fetch("summary")

      weather_hourly = weather_parsed.fetch("hourly", {"data" => ""})

      weather_minutely = weather_parsed.fetch("minutely", {"summary" => ""})
  
      weather_nexthoursummary = weather_minutely.fetch("summary") #Use this for summary of next hour

      weather_currentsummary = "Current weather is: " + weather_currentweather + ", with a temperature of " + weather_currenttemp.to_s + " degrees Farenheit. " + weather_nexthoursummary

      weather_hourly_data = weather_hourly.fetch("data")
      if weather_hourly_data == ""
        weather_hourly_data_status = false
      else
        counter = 0
        umbrella_window = 12 #Number of hours of search
        umbrella_window.to_i.times do |hour|
          precip_prob = weather_hourly_data[hour].fetch("precipProbability")
          if precip_prob > 0.5
            counter += 1
          end
        end  
      end
        p weather_currentsummary

      if counter > 0 and weather_hourly_data_status != false
        p "It's likely to rain in the next " + umbrella_window.to_s + " hours. You should take an umbrella!"
      end
    end
end