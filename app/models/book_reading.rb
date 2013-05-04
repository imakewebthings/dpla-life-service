# == Schema Information
#
# Table name: book_readings
#
#  id         :integer          not null, primary key
#  book_id    :string(255)
#  created_at :datetime
#

class BookReading < ActiveRecord::Base
  validates :book_id, presence: true
end
