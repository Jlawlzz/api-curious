class ChangeEchoIdtoIntegerSong < ActiveRecord::Migration
  def change
    change_column :songs, :echo_id, :string
  end
end
