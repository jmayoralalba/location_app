require 'test_helper'

class CreateLocationServiceTest < ActiveSupport::TestCase
  test 'location with valid attributes' do
    location = CreateLocationService.call(valid_params)

    assert location.save
  end

  test 'location with valid attributes without latitude' do
    location = CreateLocationService.call(valid_params.except(:latitude))

    assert location.save
    assert location.latitude
  end

  test 'location with valid attributes without longitude' do
    location = CreateLocationService.call(valid_params.except(:longitude))

    assert location.save
    assert location.longitude
  end

  test 'location with valid attributes without latitude and longitude' do
    location = CreateLocationService.call(valid_params.except(:latitude, :longitude))

    assert location.save
    assert location.latitude && location.longitude
  end

  test 'location with invalid attributes' do
    location = CreateLocationService.call(valid_params.merge({ latitude: 'asd' }))

    assert_not location.save
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
