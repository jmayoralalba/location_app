class GetCoordinatesService < ApplicationService
  require 'open-uri'

  API_URL = "https://maps.googleapis.com/maps/api/geocode/json?address=ADDRESS&key=API_KEY".freeze

  def initialize(params)
    @location = params[:location]
  end

  def call
    result = JSON.parse(open(form_url).read)

    if result["results"].any?
      ApplicationServiceResult.new(true, result["results"][0]["geometry"]["location"], [])
    else
      ApplicationServiceResult.new(false, nil, result["status"])
    end
  end

  private

  def encode_address
    [@location.address, @location.postcode, @location.city, @location.country].join('+').gsub(/\s+/, '+')
  end

  def form_url
    API_URL.gsub('ADDRESS', encode_address)
  end
end
