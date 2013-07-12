# == Schema Information
#
# Table name: shelf_items
#
#  id         :integer          not null, primary key
#  shelf_id   :integer
#  item_id    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShelfItem < ActiveRecord::Base
  attr_accessible :item_id

  belongs_to :shelf

  validates :shelf_id, presence: true
  validates :item_id, presence: true
end
