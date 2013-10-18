class Item < ActiveRecord::Base
  attr_accessible :folder_id, :item

  has_attached_file :item

  belongs_to :folder

  # validates :item, :attachment_presence => true
end
