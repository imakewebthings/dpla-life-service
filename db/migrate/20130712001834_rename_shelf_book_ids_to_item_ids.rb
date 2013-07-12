class RenameShelfBookIdsToItemIds < ActiveRecord::Migration
  def change
    rename_column :shelves, :book_ids, :item_ids
  end
end
