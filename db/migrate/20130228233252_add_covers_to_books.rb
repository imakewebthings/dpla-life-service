class AddCoversToBooks < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.string :cover_small
      t.string :cover_large
    end
  end
end
