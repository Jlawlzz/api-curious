$("#grid").html("<%= escape_javascript(render partial: '/users/item_grid', collection: @tracks, as: :track) %>");
