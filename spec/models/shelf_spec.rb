# == Schema Information
#
# Table name: shelves
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string(255)
#  description :text
#  book_ids    :text
#

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

  it { should have_many :shelf_items }

  it 'turns nil values of book_ids into an empty array' do
    shelf = create :shelf
    shelf.book_ids.should eq []
    shelf.book_ids = nil
    shelf.save
    shelf.book_ids.should eq []
  end
end
