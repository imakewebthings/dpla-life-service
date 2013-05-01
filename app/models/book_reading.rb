class BookReading < ActiveRecord::Base
  validates :book_id, presence: true
end