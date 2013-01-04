# == Schema Information
#
# Table name: date_ranges
#
#  id      :integer          not null, primary key
#  book_id :integer          not null
#  start   :string(255)
#  end     :string(255)
#

class DateRange < ActiveRecord::Base
  belongs_to :book

  validates :start, presence: true
  validates :end, presence: true
end
