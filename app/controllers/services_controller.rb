class ServicesController < ApplicationController

  def search
    if params['soundcloud']
      sc = SoundCloudHelper.new(set_client)
      @tracks = sc.search(params['soundcloud']['search'])
      respond_to do |format|
        format.js
      end
    end
  end

  def add_to_playlist
    if params[:service] == 'soundcloud'
      sc = SoundCloudHelper.new(set_client)
      @normalized = sc.normalize(params)
    end
    find_or_create_params
    append_to_or_create_playlist
    respond_to do |format|
      format.js
    end
  end

  private

  def find_or_create_params
    find_or_create_artist
    find_or_create_song
    assign_song
  end

  def assign_song
    if @artist
      @artist.songs << @song
    end
  end

  def find_or_create_artist
    if find_artist.nil?
      @artist = Artist.create(sc_id: @normalized[:artist][:sc_id],
                              echo_id: @normalized[:artist][:echo_id],
                              name: @normalized[:artist][:name])
    end
  end

  def find_artist
    @artist = Artist.find_by(echo_id: @normalized[:artist][:echo_id])
  end

  def find_or_create_song
    if !(find_song_by_sc_id || find_song_by_echo_id)
      @song = create_song
    end
  end

  def find_song_by_sc_id
    @song = Song.find_by(sc_id: @normalized[:song][:sc_id])
  end

  def find_song_by_echo_id
    @song = Song.find_by(echo_id: @normalized[:song][:echo_id]) if @normalized[:song][:echo_id]
  end

  def create_song
    @song = Song.create(title: @normalized[:song][:title],
                        sc_id: @normalized[:song][:sc_id],
                        sc_stream: @normalized[:song][:sc_stream])
    (@song.echo_id = @normalized[:song][:echo_id]) if @normalized[:song][:echo_id]
    @song.save
    @song
  end

  def append_to_or_create_playlist
    if current_playlist
      current_playlist.songs << @song
    else
      playlist = Playlist.create(user_id: current_user.id)
      session[:current_playlist] = playlist
      playlist.songs << @song
      current_user.playlists << playlist
    end
    @playlist = current_playlist
  end
end
