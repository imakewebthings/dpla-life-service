class AddRemoteViewerUrlToBooks < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.string :viewer_url
    end
  end
end
