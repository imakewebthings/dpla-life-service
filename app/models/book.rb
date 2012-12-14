class Book < ActiveRecord::Base
  has_many :temporals, class_name: 'DateRange'

  validates :@id, presence: true, uniqueness: true

  serialize :title
  serialize :publisher
end