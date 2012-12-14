class DateRange < ActiveRecord::Base
  belongs_to :book

  validates :start, presence: true
  validates :end, presence: true
end