class Item < ActiveRecord::Base
  attr_accessible :folder_id, :item, :item_file_name,  :item_content_type, :item_file_size, :item_updated_at

  has_attached_file :item

  has_many :comments, :as => :commentable, dependent: :destroy
  belongs_to :folder

  validates :item, :attachment_presence => true
  validates_uniqueness_of :item_file_name, :scope => :folder_id

  scope :without_folder, where(:acestry == nil)

end
