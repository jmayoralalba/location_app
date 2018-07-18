class LocationAddressDecorator
  def self.call(location)
    [location.address, location.postcode, location.city, location.country].join(' ')
  end
end
