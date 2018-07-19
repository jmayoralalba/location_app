require 'test_helper'
require 'minitest/autorun'

class Api::LocationsControllerTest < ActionDispatch::IntegrationTest
  test '#create with valid parameters' do
    post api_locations_url, as: :json, params: valid_params

    assert_response 201
  end

  test '#create with valid parameters without latitude and longitude' do
    mock = Minitest::Mock.new
    mock.expect(:run, mock_google_geocoding_json)

    GoogleGeocoding::Client.stub :new, mock do
      post api_locations_url, as: :json, params: valid_params.except(:latitude, :longitude)

      assert_response 201
      mock.verify
    end
  end

  test '#create with invalid json' do
    post api_locations_url, as: :json, params: valid_params.merge({ latitude: 'asd' })

    assert_response 400
  end

  test '#create with invalid data type' do
    assert_raises(ActionController::RoutingError) do
      post api_locations_url, params: valid_params.merge({ latitude: 'asd' })
    end
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
