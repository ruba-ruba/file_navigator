class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :role
  
  validates_uniqueness_of :email
  validates :email, :presence => true

  has_many :folders 
  has_many :items
  has_many :comments

  ROLES = %w[user admin]

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :role, :inclusion => { :in => ROLES }
end
