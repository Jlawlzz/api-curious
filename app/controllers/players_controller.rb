class PlayersController < ApplicationController

  def add_to_queue
    # if exists?
    #   set_exists
    # else
      if params[:service] == 'soundcloud'
        sc = SoundCloudHelper.new(set_client)
        @norm_data = sc.normalize(params)
        find_or_create_params
      end
    # end
    play_or_queue
    respond_to do |format|
      format.js
    end
  end

  def play_or_queue
    if session[:queue]
      append_to_queue
    else
      session[:queue] = []
      append_to_queue
    end
  end

  def play_song
    if params[:service] == 'soundcloud'
      sc = SoundCloudHelper.new(set_client)
      @norm_data = sc.normalize(params)
      find_or_create_params
    end
    respond_to do |format|
      format.js
    end
  end

  def next_song

    session[:queue].each.with_index do |song, index|
      (@index = index) if (song['id'] == params[:song].to_i)
    end
    if session[:queue][@index + 1]
      @song = Song.find(session[:queue][@index + 1]['id'].to_i)
    else
      @song = Song.find(session[:queue][0]['id'].to_i)
    end
    session[:queue].rotate!
    @artist = @song.artist
    play_song
  end

  def prev_song
    session[:queue].each.with_index do |song, index|
      if (song['id'] == params[:song].to_i)
        (@index = index)
      end
    end
    if session[:queue][@index - 1]
      @song = Song.find(session[:queue][@index - 1]['id'])
    else
      @song = Song.find(session[:queue][-1]['id'])
    end
    session[:queue].rotate!(-(session[:queue].count + 1))
    @artist = @song.artist
    play_song
  end

  def clear_queue
    session[:queue] = []
    @songqueue = session[:queue]
    respond_to do |format|
      format.js
    end
  end

  private

  def exists?
    Song.find_by(sc_id: params[:id])
  end

  def set_exists
    @song = Song.find_by(sc_id: params[:id])
    @artist = @song.artist
  end

  def find_or_create_params
    @artist = Artist.find_or_create_artist(@norm_data)
    @song = Song.find_or_create_song(@norm_data)
    assign_song
  end

  def assign_song
    if @artist
      @artist.songs << @song
    end
  end

  def append_to_queue
    session[:queue] << {'id' => @song.id, 'sc_art' => @song.sc_art, 'artist' => @artist.name, 'title' => @song.title}
    @songqueue = session[:queue]
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
