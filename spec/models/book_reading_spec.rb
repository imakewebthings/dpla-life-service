# == Schema Information
#
# Table name: book_readings
#
#  id         :integer          not null, primary key
#  book_id    :string(255)
#  created_at :datetime
#

require 'spec_helper'

describe BookReading do
  it 'has a valid mock' do
    build(:book_reading).should be_valid
  end

  it { should validate_presence_of :book_id }
  it { should_not allow_mass_assignment_of :book_id }
end
