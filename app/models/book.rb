# == Schema Information
#
# Table name: books
#
#  id          :integer          not null, primary key
#  source_id   :string(255)      not null
#  title       :string(255)
#  publisher   :string(255)
#  creator     :string(255)
#  description :text
#  source_url  :string(255)
#  viewer_url  :string(255)
#  cover_small :string(255)
#  cover_large :string(255)
#  shelfrank   :integer
#

class Book < ActiveRecord::Base
  has_many :temporals, class_name: 'DateRange', dependent: :destroy

  validates :source_id, presence: true, uniqueness: true
end
