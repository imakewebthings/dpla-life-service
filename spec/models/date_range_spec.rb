# == Schema Information
#
# Table name: date_ranges
#
#  id      :integer          not null, primary key
#  book_id :integer          not null
#  start   :string(255)
#  end     :string(255)
#

require 'spec_helper'

describe DateRange do
  it 'has a valid factory' do
    build(:date_range).should be_valid
  end

  it { should validate_presence_of :start }
  it { should validate_presence_of :end }
  it { should belong_to :book }
end
