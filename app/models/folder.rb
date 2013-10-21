class Folder < ActiveRecord::Base
  attr_accessible :title, :parent_id, :parent, :ancestry

  has_ancestry

  has_many :items, dependent: :destroy

  validates :title, presence: true, :uniqueness => true

  accepts_nested_attributes_for :items, allow_destroy: true
end
