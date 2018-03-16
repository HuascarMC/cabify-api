class Cab < ApplicationRecord

 has_one :location, dependent: :destroy

 validates_presence_of :state, :name, :city
end
