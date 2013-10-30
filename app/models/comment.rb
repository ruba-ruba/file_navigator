class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :parent_id, :user_id

  has_ancestry
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 140 }

  validates_format_of :content, :without => /php/
end
