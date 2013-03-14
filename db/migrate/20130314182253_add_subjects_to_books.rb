class AddSubjectsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :subjects, :string
    add_index :books, :subjects
  end
end
