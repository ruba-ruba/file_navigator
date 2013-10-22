class Folder < ActiveRecord::Base
  attr_accessible :title, :parent_id, :parent, :ancestry

  has_ancestry

  has_many :items, dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy

  validates :title, presence: true

  validates_uniqueness_of :title, :scope => :ancestry

  accepts_nested_attributes_for :items, allow_destroy: true
end
