class AddPlaylistIdToSongs < ActiveRecord::Migration
  def change
    add_reference :songs, :playlist, index: true, foreign_key: true
  end
end
