class CreateShelves < ActiveRecord::Migration
  def change
    create_table :shelves do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.text :book_ids
    end

    add_index :shelves, :user_id
  end
end
