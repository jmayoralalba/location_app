require 'test_helper'

class Api::LocationsControllerTest < ActionDispatch::IntegrationTest
  test '#create with valid parameters' do
    post api_locations_url, as: :json, params: valid_params

    assert_response 201
  end

  test '#create with valid parameters without latitude and longitude' do
    post api_locations_url, as: :json, params: valid_params.except(:latitude, :longitude)

    assert_response 201
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
      name: 'Name',
      phone: 'Phone',
      address: 'Address',
      postcode: 'Postcode',
      city: 'City',
      country: 'Country',
      latitude: 40.4169953,
      longitude: 3.7046471
    }
  end
end
