class TweetsController < ApplicationController
  def index
    twitter_app = ConnectedApp.where(name: 'twitter').first

    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = "BgB9gfhMrjtSb3ZAy4Zen6u1b"
      config.consumer_secret     = "4vMkasCv3xhs0mRkfEjVePrCQfqoBpxCpgXcGWGTEcE9xywqNR"
      config.access_token        = twitter_app.token
      config.access_token_secret = twitter_app.token_secret
    end

    client.sample do |object|
      puts object.text if object.is_a?(Twitter::Tweet)
    end
  end
end
