# == Schema Information
#
# Table name: books
#
#  id           :integer          not null, primary key
#  _id          :string(255)      not null
#  title        :string(255)
#  publisher    :string(255)
#  creator      :string(255)
#  description  :text
#  dplaLocation :string(255)
#  viewer_url   :string(255)
#

require 'spec_helper'

describe Book do
  it 'has a valid factory' do
    build(:book).should be_valid
  end

  it { should validate_presence_of :_id }
  it { should validate_uniqueness_of :_id }

  it { should have_many :temporals }
end
