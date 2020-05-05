task(:umbrella) do
  raw_file = open("https://api.darksky.net/forecast/26f63e92c5006b5c493906e7953da893/41.8887,-87.6355").read

  json = JSON.parse(raw_file)
  c = json.fetch("currently")
  ap c.fetch("temperature")
  
end