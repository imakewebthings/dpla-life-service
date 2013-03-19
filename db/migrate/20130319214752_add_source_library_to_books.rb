class AddSourceLibraryToBooks < ActiveRecord::Migration
  def change
    add_column :books, :source_library, :string
  end
end
