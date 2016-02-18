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
    binding.pry
  end

end
