$("#grid").html("<%= escape_javascript(render partial: '/services/item_collection', locals: {tracks: @tracks}) %>");
