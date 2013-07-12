class AddItemTypeAndSourceToShelfItem < ActiveRecord::Migration
  def change
    add_column :shelf_items, :source, :string
    add_column :shelf_items, :item_type, :string

    ShelfItem.update_all({ source: 'book_source', item_type: 'book' })
  end
end
