class RenameBookSourceToDplaLocation < ActiveRecord::Migration
  def change
    rename_column :books, :source, :dplaLocation
  end
end
