require 'spec_helper'

describe Shelf do
  it 'has a valid mock' do
    build(:shelf).should be_valid
  end

  it { should belong_to :user }

  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :description }
  it { should allow_mass_assignment_of :book_ids }
  it { should_not allow_mass_assignment_of :user_id }

  it { should validate_presence_of :name }
  it { should validate_presence_of :user_id }
end