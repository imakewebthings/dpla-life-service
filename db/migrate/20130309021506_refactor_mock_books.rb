class RefactorMockBooks < ActiveRecord::Migration
  def change
    rename_column :books, :_id, :source_id
    rename_column :books, :dplaLocation, :source_url
  end
end
