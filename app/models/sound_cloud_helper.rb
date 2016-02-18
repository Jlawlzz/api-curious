class SoundCloudHelper

  def initialize(client)
    @sc = client
  end

  def search(params)
    @sc.get('/tracks', q: params, limit: 50)
  end

  def normalize(params)
    artist = normalize_artist(params)
    song = normalize_song(params)

    return_params(params, artist, song)
  end

  def normalize_artist(params)
    artist = match_artist(params[:user][:username])
    if artist
      artist
    else
      parse_artist_from_title(params)
    end
  end

  def parse_artist_from_title(params)
    name = params[:title].split('-').first
    match_artist(name)
  end

  def normalize_song(params)
    if remix?(params)
      params
    end
  end

  def remix?(params)
    params[:title].downcase.include?('remix') || params[:title].downcase.include?('bootleg')
  end

  def match_artist(artist_name)
    Echowrap.artist_search(name: artist_name.downcase).first
  end


  def return_params(params, artist=nil, song=nil)
    {params:
      {artist:
        {name: artist.name,
         echo_id: artist.id,
         sc_id: params[:user][:id]
        },
       song:
        {title: params[:title],
         sc_id: params[:id],
         sc_stream: params[:stream_url]}
        }
      }
  end
end
