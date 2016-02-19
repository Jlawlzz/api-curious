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

  private

  
end
