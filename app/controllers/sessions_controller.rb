class SessionsController < ApplicationController

  def create
    client = Soundcloud.new(:client_id => 'YOUR_CLIENT_ID',
                           :client_secret => 'YOUR_CLIENT_SECRET',
                           :redirect_uri => 'http://example.com/callback')
    if @user
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
