require 'rails_helper'

RSpec.describe Cab, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should have_many(:location).dependent(:destroy) }

  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:city) }

end
