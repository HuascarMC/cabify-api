require 'rails_helper'

RSpec.describe Location, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to(:cab) }

  it {should validate_presence_of(:lon) }
  it {should validate_presence_of(:lat) }
end
