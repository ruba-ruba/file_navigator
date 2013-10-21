class Item < ActiveRecord::Base
  attr_accessible :folder_id, :item, :item_file_name,  :item_content_type, :item_file_size, :item_updated_at
  has_attached_file :item

  belongs_to :folder

  validates :item, :attachment_presence => true

  scope :without_folder, where(:acestry == nil)

end
