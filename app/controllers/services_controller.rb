class ServicesController < ApplicationController

  def new
    client = Soundcloud.new(:client_id => 'e6cec03e9db1f86a994857320fa6b7e3',
                        :client_secret => '82d05d53abcd4e4b44a4e1ddf5baed29',
                        :redirect_uri => 'http://localhost:3000/callback')

    redirect_to client.authorize_url()
  end

  def create
    client = Soundcloud.new(:client_id => 'e6cec03e9db1f86a994857320fa6b7e3',
                        :client_secret => '82d05d53abcd4e4b44a4e1ddf5baed29',
                        :redirect_uri => 'http://localhost:3000/callback')
                        # raise params.inspect
    code = params[:code]
    session[:access_token] = client.exchange_token(:code => code)

    username = set_client.get('/me').username

    @user = User.find_by(username: username)

    if @user
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      @user = User.create(username: username)
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    end
  end

end
