class Item < ActiveRecord::Base
  attr_accessible :folder_id, :item, :item_file_name,  :item_content_type, :item_file_size, :item_updated_at

  has_attached_file :item,
                    :url  => "/system/:attachment/:id/:style_:filename",
                    :path => ":rails_root/public/system/:attachment/:id/:style_:filename" 

  has_many :comments, :as => :commentable, dependent: :destroy
  belongs_to :folder
  belongs_to :user

  delegate :path, :to => :user, :allow_nil => true

  validates :item, :attachment_presence => true
  validates_uniqueness_of :item_file_name, :scope => :folder_id

  scope :without_folder, where(:folder_id => nil)

  DummyFolder = Struct.new(:parent)

  def path(root = folder)
    folder.parent = folder
    folder ? folder.path(root) : nil
  end

  def self.daily_mailer
    items = Item.where('created_at >= ?', 24.hours.ago)
    DailyMailer.delay_for(0.minutes).daily_notification(items.all)
  end

  

end
