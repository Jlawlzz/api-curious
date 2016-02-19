$("#grid").html("<%= escape_javascript(render partial: '/users/item_collection', locals: {tracks: @tracks}) %>");
