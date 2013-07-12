class RenameShelfBookToShelfItem < ActiveRecord::Migration
  def change
    rename_table :shelf_books, :shelf_items
  end
end
