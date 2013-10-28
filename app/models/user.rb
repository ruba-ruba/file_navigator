class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :role
  
  validates_uniqueness_of :email

  has_many :folders 
  has_many :items
  has_many :comments

  ROLES = %w[user admin]

  after_create :default_role
  
  private
  def default_role
    self.update_attributes(:role => 'user')
  end

end
