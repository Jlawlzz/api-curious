class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :playlist

  def self.find_or_create_song(norm_data)
    @norm_data = norm_data
    if !(song = find_song_by_sc_id || song = find_song_by_echo_id)
      song = create_song
    end
    song
  end

  def self.find_song_by_sc_id
    Song.find_by(sc_id: @norm_data[:song][:sc_id])
  end

  def self.find_song_by_echo_id
    Song.find_by(echo_id: @norm_data[:song][:echo_id]) if @norm_data[:song][:echo_id]
  end

  def self.create_song
    song = Song.create(title: @norm_data[:song][:title],
                        sc_id: @norm_data[:song][:sc_id],
                        sc_stream: @norm_data[:song][:sc_stream],
                        sc_art: @norm_data[:song][:sc_art])
    (song.echo_id = @norm_data[:song][:echo_id]) if @norm_data[:song][:echo_id]
    song.save
    @song = song
    song
  end

end
