class GoogleGeocoding
  require 'open-uri'

  URL = "https://maps.googleapis.com/maps/api/geocode/json?address=ADDRESS&key=API_KEY".freeze

  def initialize(location, api_key)
    @location = location
    @api_key  = api_key
  end

  def get_coordinates
    result = JSON.parse(open(form_url).read)

    if result["results"].any?
      result["results"][0]["geometry"]["location"]
    else
      nil
    end
  end

  private

  def encode_address
    [@location.address, @location.postcode, @location.city, @location.country].join('+').gsub(/\s+/, '+')
  end

  def form_url
    URL.gsub('ADDRESS', encode_address).gsub('API_KEY', @api_key)
  end
end
