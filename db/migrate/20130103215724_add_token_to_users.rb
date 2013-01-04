class AddTokenToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :token
    end

    add_index :users, :token
  end
end
