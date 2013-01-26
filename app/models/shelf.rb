class Shelf < ActiveRecord::Base
  attr_accessible :name, :description, :book_ids

  serialize :book_ids

  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true
end