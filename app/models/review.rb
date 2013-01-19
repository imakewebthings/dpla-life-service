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

class Review < ActiveRecord::Base
  attr_accessible :comment, :rating, :book_id

  belongs_to :user

  validates :book_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :book_id }
  validates :comment, presence: true, :unless => :rating?
  validates :rating, inclusion: 1..5
end
