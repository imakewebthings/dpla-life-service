require 'spec_helper'

describe Book do
  it 'has a valid factory' do
    build(:book).should be_valid
  end

  it { should validate_presence_of :@id }
  it { should validate_uniqueness_of :@id }
end