class Location < ApplicationRecord
  validates :name,      presence: true, length: { in: 1..255 }
  validates :phone,     presence: true, length: { in: 1..255 }
  validates :address,   presence: true
  validates :postcode,  presence: true, length: { in: 1..255 }
  validates :city,      presence: true, length: { in: 1..255 }
  validates :country,   presence: true, length: { in: 1..255 }
  validates :latitude,  presence: true, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  def as_json(options = {})
    h = super(options.merge({ except: [ :created_at, :updated_at ] }))

    h[:latitude]  = self.latitude.to_f
    h[:longitude] = self.longitude.to_f

    h
  end
end
