require 'test_helper'

class CreateLocationServiceTest < ActiveSupport::TestCase
  test 'location with valid attributes' do
    result = CreateLocationService.call(valid_params)

    assert result.success
  end

  test 'location with valid attributes without latitude' do
    result = CreateLocationService.call(valid_params.except(:latitude))

    assert result.success
  end

  test 'location with valid attributes without longitude' do
    result = CreateLocationService.call(valid_params.except(:longitude))

    assert result.success
  end

  test 'location with valid attributes without latitude and longitude' do
    result = CreateLocationService.call(valid_params.except(:latitude, :longitude))

    assert result.success
  end

  test 'location with invalid attributes' do
    result = CreateLocationService.call(valid_params.merge({ latitude: 'asd' }))

    assert_not result.success
  end

  private

  def valid_params
    {
      name: 'Apple Store Puerta del Sol',
      phone: '917 69 91 00',
      address: 'Plaza de la Puerta del Sol, 1',
      postcode: '28013',
      city: 'Madrid',
      country: 'Spain',
      latitude: 40.4169953,
      longitude: -3.7046471,
    }
  end
end
