require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test 'location with valid attributes' do
    assert Location.new(valid_params).valid?
  end

  test 'location with invalid latitude format' do
    location = Location.new(valid_params.merge({ latitude: 'not valid'}))

    assert_error location, { latitude: :not_a_number }
  end

  test 'location with invalid greater latitude range' do
    location = Location.new(valid_params.merge({ latitude: 91}))

    assert_error location, { latitude: :less_than_or_equal_to }
  end

  test 'location with invalid lesser latitude range' do
    location = Location.new(valid_params.merge({ latitude: -91}))

    assert_error location, { latitude: :greater_than_or_equal_to }
  end

  test 'location with invalid longitude format' do
    location = Location.new(valid_params.merge({ longitude: 'not valid'}))

    assert_error location, { longitude: :not_a_number }
  end

  test 'location with invalid greater longitude range' do
    location = Location.new(valid_params.merge({ longitude: 181}))

    assert_error location, { longitude: :less_than_or_equal_to }
  end

  test 'location with invalid lesser longitude range' do
    location = Location.new(valid_params.merge({ longitude: -181}))

    assert_error location, { longitude: :greater_than_or_equal_to }
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
