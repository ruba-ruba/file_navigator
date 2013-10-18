class Folder < ActiveRecord::Base
  attr_accessible :title, :parent_id, :parent, :ancestry

  has_ancestry

  has_many :items, dependent: :destroy

  validates :title, presence: true, :uniqueness => true

  def uniqness_on_level
    self.siblings 
  end
end
