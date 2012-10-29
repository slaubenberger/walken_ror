# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  user_id    :integer
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rating < ActiveRecord::Base
  attr_accessible :movie_id, :rating, :user_id
end
