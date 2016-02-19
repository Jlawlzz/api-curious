class Playlist < ActiveRecord::Base
  has_many :songs

  def next_song
    
  end
end
