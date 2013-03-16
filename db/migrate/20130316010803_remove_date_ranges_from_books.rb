class RemoveDateRangesFromBooks < ActiveRecord::Migration
  def change
    drop_table :date_ranges
    add_column :books, :pub_date, :integer
  end
end
