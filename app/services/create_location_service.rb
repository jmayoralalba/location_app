class CreateLocationService < ApplicationService
  def initialize(location_params)
    @location_params = location_params
  end

  def call
    location = Location.new(@location_params)

    if location.latitude.nil? || location.longitude.nil?
      add_coordinates(location)
    end

    return location
  end

  private

  def add_coordinates(location)
    result = GoogleGeocoding.new(LocationAddressDecorator.call(location), Rails.application.credentials.google_api_key).get_coordinates

    if result["results"].any?
      location.latitude  = result["results"][0]["geometry"]["location"]["lat"]
      location.longitude = result["results"][0]["geometry"]["location"]["lng"]
    end
  end
end
