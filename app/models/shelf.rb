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

class Shelf < ActiveRecord::Base
  attr_accessible :name, :description, :book_ids

  serialize :book_ids

  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true
end
