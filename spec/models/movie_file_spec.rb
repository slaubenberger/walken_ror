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

require 'spec_helper'

describe MovieFile do
  pending "add some examples to (or delete) #{__FILE__}"
end
