Geocoder.configure({
  lookup: :bing,
  api_key: ENV.fetch("BING_MAPS_API_KEY"),
})
