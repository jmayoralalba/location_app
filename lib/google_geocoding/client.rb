require 'open-uri'

module GoogleGeocoding
  class Client
    URL = "https://maps.googleapis.com/maps/api/geocode/json?address=ADDRESS&key=API_KEY".freeze

    def initialize(address, api_key)
      @address = address
      @api_key = api_key
    end

    def call
      begin
        JSON.parse(open(form_url).read)
      rescue OpenURI::HTTPError => error
        raise Error.new(error.io.status)
      end
    end

    private

    def encode_address
      @address.gsub(/\s+/, '+')
    end

    def form_url
      URL.gsub('ADDRESS', encode_address).gsub('API_KEY', @api_key)
    end
  end
end
