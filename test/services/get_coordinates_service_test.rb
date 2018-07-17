require 'test_helper'

class GetCoordinatesServiceTest < ActiveSupport::TestCase
  test 'valid location' do
    location = locations(:apple_store_puerta_sol)

    result = GetCoordinatesService.call({ location: location })

    assert result.success
  end

  test 'invalid location' do
    location = locations(:apple_store_puerta_sol)
    location.address = 'This place does not exist'

    result = GetCoordinatesService.call({ location: location })

    assert result.success
  end
end
