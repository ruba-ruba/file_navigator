class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content

  has_ancestry
  
  belongs_to :commentable, :polymorphic => true

  validates :content, :presence => true, :length => { :maximum => 140 }

  validates_format_of :content, :without => /php/
end
