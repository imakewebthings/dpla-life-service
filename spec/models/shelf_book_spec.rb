require 'spec_helper'

describe ShelfBook do
  it 'has a valid mock' do
    build(:shelf_book).should be_valid
  end

  it { should validate_presence_of :shelf_id }
  it { should_not allow_mass_assignment_of :shelf_id }

  it { should validate_presence_of :book_id }
  it { should allow_mass_assignment_of :book_id }
end