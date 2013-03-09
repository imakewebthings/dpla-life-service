class AddShelfrankToBooks < ActiveRecord::Migration
  def change
    add_column :books, :shelfrank, :integer
    add_index :books, :shelfrank
  end
end
