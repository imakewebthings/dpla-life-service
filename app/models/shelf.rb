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
  attr_accessible :name, :description, :item_ids

  before_save :ensure_item_id_array

  belongs_to :user
  has_many :shelf_items, dependent: :destroy
  serialize :item_ids

  validates :name, presence: true
  validates :user_id, presence: true

  def ensure_item_id_array
    self.item_ids = [] if self.item_ids.nil?
  end
end
