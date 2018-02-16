class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

private

  def authenticate_user
    client_id = ENV['FOURSQUARE_CLIENT_ID']
    redirect_uri = CGI.escape("https://18ed54df370e42e78c2e14db5d277c73.vfs.cloud9.us-east-1.amazonaws.com/auth")
    foursquare_url = "https://foursquare.com/oauth2/authenticate?client_id=#{client_id}&response_type=code&redirect_uri=#{redirect_uri}"
    
    #binding.pry
    
    redirect_to foursquare_url unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
  
end
