class ShelfBook < ActiveRecord::Base
  attr_accessible :book_id

  belongs_to :shelf

  validates :shelf_id, presence: true
  validates :book_id, presence: true
end