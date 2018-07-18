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
    coordinates = GetCoordinatesService.call({ location: location })

    location.latitude  = coordinates["lat"]
    location.longitude = coordinates["lng"]
  end
end
