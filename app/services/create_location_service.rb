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
    coordinates = get_coordinates(location)

    if coordinates
      location.latitude  = coordinates["lat"]
      location.longitude = coordinates["lng"]
    end
  end

  def get_coordinates(location)
    result = GoogleGeocoding::Client.new(LocationAddressDecorator.call(location), Rails.application.credentials.google_api_key).run

    if result["results"].any?
      return result["results"][0]["geometry"]["location"]
    else
      return nil
    end
  end
end
