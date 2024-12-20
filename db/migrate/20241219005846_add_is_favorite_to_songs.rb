class AddIsFavoriteToSongs < ActiveRecord::Migration[7.2]
  def change
    add_column :songs, :is_favorite, :boolean
  end
end
