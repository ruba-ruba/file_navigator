class Item < ActiveRecord::Base
  attr_accessible :folder_id, :item, :item_file_name

  has_attached_file :item

  belongs_to :folder

  validates :folder_id, presence: true

  validates :item, :attachment_presence => true
end
