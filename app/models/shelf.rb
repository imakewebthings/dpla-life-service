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

  before_save :ensure_book_id_array

  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true

  def ensure_book_id_array
    self.book_ids = [] if self.book_ids.nil?
  end
end
