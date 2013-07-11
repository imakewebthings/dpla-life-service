# == Schema Information
#
# Table name: shelf_books
#
#  id         :integer          not null, primary key
#  shelf_id   :integer
#  item_id    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe ShelfBook do
  it 'has a valid mock' do
    build(:shelf_book).should be_valid
  end

  it { should validate_presence_of :shelf_id }
  it { should_not allow_mass_assignment_of :shelf_id }

  it { should validate_presence_of :item_id }
  it { should allow_mass_assignment_of :item_id }
end
