class Api::LocationsController < ApplicationController
  before_action :load_json_schema

  def create
    location = CreateLocationService.call(@json_params)

    if location.save
      render json: { location: location }, status: 201
    else
      render json: { errors: location.errors.full_messages }, status: 400
    end
  end

  private

  def load_json_schema
    schema = {
      "type" => "object",
      "required" => ["name", "phone", "address", "postcode", "city", "country"],
      "properties" => {
        "name"      => { "type" => "string" },
        "phone"     => { "type" => "string" },
        "address"   => { "type" => "string" },
        "postcode"  => { "type" => "string" },
        "city"      => { "type" => "string" },
        "country"   => { "type" => "string" },
        "latitude"  => { "type" => "number" },
        "longitude" => { "type" => "number" }
      }
    }

    @json_params = JSON.parse(request.body.read)
    return if JSON::Validator.validate(schema, @json_params)
    head(400)
  end
end
