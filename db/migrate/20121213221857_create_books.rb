class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :@id, null: false
      t.string :title
      t.string :publisher
      t.string :creator
      t.text :description
      t.string :source
    end

    add_index :books, :@id, unique: true
  end
end
