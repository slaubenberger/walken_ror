class MovieFile < ActiveRecord::Base
  attr_accessible :description, :movie_id, :path, :user_id
end
