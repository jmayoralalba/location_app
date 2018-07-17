class CreateLocationService < ApplicationService
  def initialize(location_params)
    @location_params = location_params
  end

  def call
    location = Location.new(@location_params)

    if location.latitude.nil? || location.longitude.nil?
      add_coordinates(location)
    end

    return ApplicationServiceResult.new(location.save, location, location.errors.full_messages)
  end

  private

  def add_coordinates(location)
    coordinates = get_coordinates(location)

    location.latitude  = coordinates["lat"]
    location.longitude = coordinates["lng"]
  end

  def get_coordinates(location)
    result = GetCoordinatesService.call({ location: location })

    return result.success ? result.value : nil
  end
end
