class AddScArtToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :sc_art, :string
  end
end
