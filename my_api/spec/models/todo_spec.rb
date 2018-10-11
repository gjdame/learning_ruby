require 'rails_helper'

RSpec.describe Todo, type: :model do

	       #association test, ensure 1:many relationship iun item
	       it { should have_many(:items).dependent(:destroy) }

	       #validation tests, ensure existence
	       it { should validate_presence_of(:title) }
	       it { should validate_presence_of(:created_by) }

end
