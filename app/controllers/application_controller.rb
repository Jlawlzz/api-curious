class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :set_client, :current_user

  def set_client
    @client = Soundcloud.new(:access_token => session[:access_token]['access_token']) if session[:access_token]
    @client
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_playlist
    @current_playlist ||= Playlist.find(session[:playlist]) if session[:playlist]
  end

  def queue
    session[:queue]
  end
end
