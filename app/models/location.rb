class Location < ApplicationRecord
  belongs_to :cab

  validates_presence_of :lon, :lat
end
