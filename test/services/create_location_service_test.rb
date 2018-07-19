require 'test_helper'
require 'minitest/autorun'

class CreateLocationServiceTest < ActiveSupport::TestCase
  test 'location with valid attributes' do
    location = CreateLocationService.call(valid_params)

    assert location.save
  end

  test 'location with valid attributes without latitude and longitude' do
    mock = Minitest::Mock.new
    mock.expect(:run, mock_google_geocoding_json)

    GoogleGeocoding::Client.stub :new, mock do
      location = CreateLocationService.call(valid_params.except(:latitude, :longitude))

      assert location.save
      assert location.latitude && location.longitude
      mock.verify
    end
  end

  test 'location with valid attributes without latitude' do
    location = CreateLocationService.call(valid_params.except(:latitude))

    assert_error location, { latitude: :blank }
  end

  test 'location with valid attributes without longitude' do
    location = CreateLocationService.call(valid_params.except(:longitude))

    assert_error location, { longitude: :blank }
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

  def mock_google_geocoding_json
    JSON.parse('{
      "results" : [
        {
          "address_components" : [
            {
              "long_name" : "Plaza Puerta del Sol",
              "short_name" : "Plaza Puerta del Sol",
              "types" : [ "route" ]
            },
            {
              "long_name" : "Madrid",
              "short_name" : "Madrid",
              "types" : [ "locality", "political" ]
            },
            {
              "long_name" : "Madrid",
              "short_name" : "M",
              "types" : [ "administrative_area_level_2", "political" ]
            },
            {
              "long_name" : "Comunidad de Madrid",
              "short_name" : "Comunidad de Madrid",
              "types" : [ "administrative_area_level_1", "political" ]
            },
            {
              "long_name" : "Spain",
              "short_name" : "ES",
              "types" : [ "country", "political" ]
            },
            {
              "long_name" : "28013",
              "short_name" : "28013",
              "types" : [ "postal_code" ]
            }
          ],
          "formatted_address" : "Plaza Puerta del Sol, 28013 Madrid, Spain",
          "geometry" : {
            "bounds" : {
              "northeast" : {
                "lat" : 40.4174099,
                "lng" : -3.7020877
              },
              "southwest" : {
                "lat" : 40.4163629,
                "lng" : -3.7046841
              }
            },
            "location" : {
              "lat" : 40,
              "lng" : -3
            },
            "location_type" : "GEOMETRIC_CENTER",
            "viewport" : {
              "northeast" : {
                "lat" : 40.4182353802915,
                "lng" : -3.702036919708497
              },
              "southwest" : {
                "lat" : 40.4155374197085,
                "lng" : -3.704734880291502
              }
            }
          },
          "place_id" : "ChIJE5ElGX4oQg0Rl34l2zxC5Jk",
          "types" : [ "route" ]
        }
      ],
      "status" : "OK"
    }')
  end
end
