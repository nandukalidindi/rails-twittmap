class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    @tweets = Tweet.search(params[:search]).records
    @hash = Gmaps4rails.build_markers(@tweets) do |tweet, marker|
              marker.lat tweet.location[1]
              marker.lng tweet.location[0]
              marker.infowindow tweet.text
            end
  end
end
