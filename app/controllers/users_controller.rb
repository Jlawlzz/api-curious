class UsersController < ApplicationController

  def show
    @user = set_client.get('/me') if set_client
    @tracks = nil
  end

end
