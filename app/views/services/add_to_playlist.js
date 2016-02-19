console.log('play?')
$("#play-window").html("<%= escape_javascript(render partial: '/songs/display_song', locals: {song: @song}) %>");
playSong(230155983)
