class Cab < ApplicationRecord

 has_many :location, dependent: :destroy

 validates_presence_of :state, :name, :city
end
