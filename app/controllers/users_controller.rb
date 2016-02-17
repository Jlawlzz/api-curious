class UsersController < ApplicationController

  before_action :set_client

  def show
    @user = set_client.get('/me')
    @tracks = nil
  end

end
