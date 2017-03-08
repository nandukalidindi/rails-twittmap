require 'elasticsearch/model'

class Tweet < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mapping do
    indexes :text, type: 'string'
    indexes :location, type: 'geo_point'
  end

  def as_indexed_json(options={})
    as_json(only: 'text').merge location: { lat: self.location[1], lon: self.location[0] }
  end
end

Tweet.__elasticsearch__.create_index! force: true
