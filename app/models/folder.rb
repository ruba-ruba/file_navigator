class Folder < ActiveRecord::Base
  attr_accessible :title, :parent_id

  has_ancestry

  has_many :items
end
