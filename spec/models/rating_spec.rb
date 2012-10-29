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

require 'spec_helper'

describe Rating do
  pending "add some examples to (or delete) #{__FILE__}"
end
