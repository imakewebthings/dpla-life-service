# == Schema Information
#
# Table name: reviews
#
#  id      :integer          not null, primary key
#  book_id :string(255)      not null
#  user_id :integer          not null
#  rating  :integer
#  comment :text
#

require 'spec_helper'

describe Review do
  it 'has a valid factory' do
    build(:review).should be_valid
  end

  it { should validate_presence_of :book_id }
  it { should validate_presence_of :user_id }
  it { should ensure_inclusion_of(:rating).in_range 1..5 }

  it 'requires at least a comment or a rating' do
    build(:review, comment: nil, rating: nil).should_not be_valid
  end
end
