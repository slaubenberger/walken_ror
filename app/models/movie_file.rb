# == Schema Information
#
# Table name: movie_files
#
#  id          :integer          not null, primary key
#  movie_id    :integer
#  user_id     :integer
#  path        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MovieFile < ActiveRecord::Base
  attr_accessible :description, :movie_id, :path, :user_id
end
