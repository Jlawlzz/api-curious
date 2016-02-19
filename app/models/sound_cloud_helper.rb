class SoundCloudHelper

  def initialize(client)
    @sc = client
  end

  def search(params)
    @sc.get('/tracks', q: params, limit: 50)
  end

  def normalize(params)
    artist = normalize_artist(params)
    song = normalize_song(params, artist)
    return_params(params, artist, song)
  end

  def normalize_artist(params)
    artist = match_artist(params[:user][:username])
    if artist && (artist.name.downcase == params[:user][:username].downcase)
      artist
    else
      name = parse_artist_from_title(params)
      match_artist(name)
    end
  end

  def normalize_song(params, artist)
    if remix?(params)
      title = parse_song_from_title(params)
      song_identifier(title)
    elsif artist
      title = parse_song_from_title(params)
      match_song(title, artist.name)
    else
      title = parse_song_from_title(params)
      song_identifier(title)
    end
  end

  def remix?(params)
    params[:title].downcase.include?('remix') || params[:title].downcase.include?('bootleg')
  end

  def song_identifier(title)
    Echowrap.song_search(title: title).first if title
  end

  def parse_artist_from_title(params)
    params[:title].split('-').first
  end

  def match_artist(artist_name)
    Echowrap.artist_search(name: artist_name.downcase).first
  end

  def parse_song_from_title(params)
     if params[:title].include?('-')
       params[:title].split('-')[1]
     else
       params[:title]
     end
  end

  def match_song(song_title, artist_name)
    Echowrap.song_search(title: song_title.downcase, artist: artist_name.downcase).first
  end

  def return_params(params, artist=nil, song=nil)
    artist = set_artist_params(params, artist)
    song = set_song_params(params, song)

      {artist:
        {name: artist[:name],
         echo_id: artist[:echo_id],
         sc_id: artist[:sc_id]
        },
       song:
        {title: song[:title],
         sc_id: song[:sc_id],
         sc_stream: song[:sc_stream],
         echo_id: song[:echo_id]
        }
       }
  end

  def set_artist_params(params, artist=nil)
    if artist
      {name: artist.name, sc_id: params[:user][:id], echo_id: artist.id}
    else
      {}
    end
  end

  def set_song_params(params, song=nil)
    if song
      {title: song.title, sc_id: params[:id], sc_stream: params[:stream_url], echo_id: song.id}
    else
      {title: parse_song_from_title(params), sc_id: params[:id], sc_stream: params[:stream_url]}
    end
  end
end
