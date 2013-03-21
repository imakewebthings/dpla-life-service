class CreateShelfBook < ActiveRecord::Migration
  def change
    create_table :shelf_books do |t|
      t.integer :shelf_id
      t.string :book_id
      t.timestamps
    end

    add_index :shelf_books, :shelf_id
    add_index :shelf_books, :book_id
    add_index :shelf_books, [:shelf_id, :book_id], unique: true
  end
end
