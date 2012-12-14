require 'spec_helper'

describe DateRange do
  it 'has a valid factory' do
    build(:date_range).should be_valid
  end

  it { should validate_presence_of :start }
  it { should validate_presence_of :end }
  it { should belong_to :book }
end