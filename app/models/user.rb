class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :password_digest, :remember_token
end
