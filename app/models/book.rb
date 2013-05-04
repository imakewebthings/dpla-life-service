# == Schema Information
#
# Table name: books
#
#  id                         :integer          not null, primary key
#  source_id                  :string(255)      not null
#  title                      :string(255)
#  publisher                  :string(255)
#  creator                    :string(255)
#  description                :text
#  source_url                 :string(255)
#  viewer_url                 :string(255)
#  cover_small                :string(255)
#  cover_large                :string(255)
#  shelfrank                  :integer
#  subjects                   :string(255)
#  pub_date                   :integer
#  measurement_page_numeric   :integer
#  measurement_height_numeric :integer
#  source_library             :string(255)
#

class Book < ActiveRecord::Base
  validates :source_id, presence: true, uniqueness: true
  serialize :subjects
end
