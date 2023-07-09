class AddFavoriteStyleIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :favorite_style_id, :integer
  end
end
