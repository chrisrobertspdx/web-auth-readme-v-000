class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
    
  def create
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
    req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
    req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
    req.params['grant_type'] = 'authorization_code'
    req.params['redirect_uri'] = "https://18ed54df370e42e78c2e14db5d277c73.vfs.cloud9.us-east-1.amazonaws.com/auth"
    req.params['code'] = params[:code]
  end

  body = JSON.parse(resp.body)
  session[:token] = body["access_token"]
  redirect_to root_path
end
end
