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

  def self.recent_most_read
    select('book_id')
      .where(created_at: (Time.now - 4.weeks)..Time.now)
      .group('book_id')
      .order('count_book_id DESC')
      .count('book_id')
  end
end
