class AddNumericsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :measurement_page_numeric, :integer
    add_column :books, :measurement_height_numeric, :integer
  end
end
