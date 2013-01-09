# == Schema Information
#
# Table name: books
#
#  id          :integer          not null, primary key
#  _id         :string(255)      not null
#  title       :string(255)
#  publisher   :string(255)
#  creator     :string(255)
#  description :text
#  source      :string(255)
#

class Book < ActiveRecord::Base
  has_many :temporals, class_name: 'DateRange'

  validates :_id, presence: true, uniqueness: true

  serialize :title
  serialize :publisher
end
