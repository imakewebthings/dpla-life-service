class CreateDateRanges < ActiveRecord::Migration
  def change
    create_table :date_ranges do |t|
      t.integer :book_id, null: false
      t.string :start
      t.string :end
    end

    add_index :date_ranges, :book_id
  end
end
