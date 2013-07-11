class RenameShelfBookBookIdToItemId < ActiveRecord::Migration
  def change
    rename_column :shelf_books, :book_id, :item_id
  end
end
