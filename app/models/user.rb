class User < ActiveRecord::Base
  has_one :role_user
  attr_accessible :email, :password, :password_confirmation,:count,:last_login
  has_secure_password
  validates_presence_of :password, :on => :create

    
end
