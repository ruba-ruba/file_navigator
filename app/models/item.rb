class Item < ActiveRecord::Base
  attr_accessible :folder_id, :item, :item_file_name,  :item_content_type, :item_file_size, :item_updated_at

  has_attached_file :item,
                    :url  => "/system/:attachment/:id/:style_:filename",
                    :path => ":rails_root/public/system/:attachment/:id/:style_:filename" 

  has_many :comments, :as => :commentable, dependent: :destroy
  belongs_to :folder
  belongs_to :user

  validates :item, :attachment_presence => true
  validates_uniqueness_of :item_file_name, :scope => :folder_id

  scope :without_folder, where(:folder_id => nil)

  def path
    folder ? folder.path : nil
  end

end



# if folder_id.nil?
#   nil
# else
#   result = []
#   folder = self.folder
#   while folder do
#     result << folder.title
#     folder = folder.parent
#   end
#   result.reverse.join("/")
# end