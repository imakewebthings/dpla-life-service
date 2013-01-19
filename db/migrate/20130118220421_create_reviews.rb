class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :book_id, null: false
      t.references :user, null: false
      t.integer :rating
      t.text :comment
    end

    add_index :reviews, :book_id
    add_index :reviews, :user_id
  end
end