require 'test_helper'
require 'webmock/minitest'

class CreateLocationServiceTest < ActiveSupport::TestCase
  test 'location with valid attributes' do
    location = CreateLocationService.call(valid_params)

    assert location.save
  end

  test 'location with valid attributes without latitude and longitude' do
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=Plaza%20de%20la%20Puerta%20del%20Sol,%201%2028013%20Madrid%20Spain&key=" + Rails.application.credentials.google_api_key).to_return(status: 200, body: google_geocoding_response, headers: {})

    location = CreateLocationService.call(valid_params.except(:latitude, :longitude))

    assert location.save
    assert location.latitude && location.longitude
  end

  test 'location with valid attributes without latitude' do
    location = CreateLocationService.call(valid_params.except(:latitude))

    assert_error location, { latitude: :blank }
  end

  test 'location with valid attributes without longitude' do
    location = CreateLocationService.call(valid_params.except(:longitude))

    assert_error location, { longitude: :blank }
  end

  test 'location with not existent address' do
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=Plaza%20de%20la%20Puerta%20del%20Sol,%201%2028013%20Madrid%20Spain&key=" + Rails.application.credentials.google_api_key).to_return(status: 200, body: google_geocoding_no_results_response, headers: {})

    location = CreateLocationService.call(valid_params.except(:latitude, :longitude))

    assert_error location, { latitude: :blank }
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

  def google_geocoding_response
    '{
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
    }'
  end

  def google_geocoding_no_results_response
    '{
      "results" : [],
      "status" : "ZERO_RESULTS_FOUND"
    }'
  end
end
