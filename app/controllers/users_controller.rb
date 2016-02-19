class UsersController < ApplicationController

  def show
    if current_user && current_user.id == params[:id].to_i
      @user = set_client.get('/me') if set_client
      @tracks = nil
    else
      redirect_to '/'
    end
  end

end
