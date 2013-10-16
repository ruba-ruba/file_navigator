class Folder < ActiveRecord::Base
  attr_accessible :title, :parent_id

  has_ancestry

  has_many :items, dependent: :destroy

  validates :title, presence: true, :uniqueness => true
end
