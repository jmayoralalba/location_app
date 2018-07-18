require 'test_helper'

class GetCoordinatesServiceTest < ActiveSupport::TestCase
  test 'valid location' do
    location = locations(:apple_store_puerta_sol)

    coordinates = GetCoordinatesService.call({ location: location })

    assert coordinates["lat"] && coordinates["lng"]
  end

  test 'invalid location' do
    location = Location.new()

    coordinates = GetCoordinatesService.call({ location: location })

    assert coordinates.nil?
  end
end
