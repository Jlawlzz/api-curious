class UsersController < ApplicationController

  before_action :set_client

  def show
    @user = set_client.get('/me')
  end

end
