class CreateBookReadings < ActiveRecord::Migration
  def change
    create_table :book_readings do |t|
      t.string :book_id
      t.datetime :created_at
    end

    add_index :book_readings, :created_at
  end
end
