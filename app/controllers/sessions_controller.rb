class SessionsController < ApplicationController

  def new
    client = Soundcloud.new(:client_id => 'e6cec03e9db1f86a994857320fa6b7e3',
                        :client_secret => '82d05d53abcd4e4b44a4e1ddf5baed29',
                        :redirect_uri => 'http://localhost:3000/callback')
    redirect_to client.authorize_url()
  end

  def create
    if params[:provider] == 'google'
      google_login
    else
      soundcloud_session
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def google_login
    @user = User.find_or_create_by_auth(request.env['omniauth.auth'])
    if @user
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to root_path
    end
  end

  def soundcloud_session
    client = Soundcloud.new(:client_id => 'e6cec03e9db1f86a994857320fa6b7e3',
                        :client_secret => '82d05d53abcd4e4b44a4e1ddf5baed29',
                        :redirect_uri => 'http://localhost:3000/callback')
    code = params[:code]
    session[:access_token] = client.exchange_token(:code => code)
    redirect_to user_path(current_user)
  end

end
