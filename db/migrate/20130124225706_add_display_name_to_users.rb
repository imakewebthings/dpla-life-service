class AddDisplayNameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :display_name
    end
  end
end
