class TweetsController < ApplicationController
  def index
    twitter_app = ConnectedApp.where(name: 'twitter').first

    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = "BgB9gfhMrjtSb3ZAy4Zen6u1b"
      config.consumer_secret     = "4vMkasCv3xhs0mRkfEjVePrCQfqoBpxCpgXcGWGTEcE9xywqNR"
      config.access_token        = twitter_app.token
      config.access_token_secret = twitter_app.token_secret
    end

    client.filter(locations: "-180, -90, 180, 90") do |object|
      if object.is_a?(Twitter::Tweet)
        unless object.geo.nil?
          location = [object.geo.longitude, object.geo.latitude]
          Tweet.create(text: object.text, location: location)
        end
      end
    end
  end
end
