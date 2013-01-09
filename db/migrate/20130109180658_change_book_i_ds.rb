class ChangeBookIDs < ActiveRecord::Migration
  def change
    rename_column :books, :@id, :_id
  end
end
