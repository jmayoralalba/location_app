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
      name: 'Name',
      phone: 'Phone',
      address: 'Address',
      postcode: 'Postcode',
      city: 'City',
      country: 'Country',
      latitude: 40.4169953,
      longitude: 3.7046471,
    }
  end
end
