class Item < ActiveRecord::Base
  attr_accessible :folder_id, :item, :item_file_name,  :item_content_type, :item_file_size, :item_updated_at, :duplicate

  has_attached_file :item,
                    :url  => "/system/:attachment/:id/:style_:filename",
                    :path => ":rails_root/public/system/:attachment/:id/:style_:filename" 

  has_many :comments, :as => :commentable, dependent: :destroy
  has_many :lists, dependent: :destroy
  belongs_to :folder
  belongs_to :user

  delegate :path, :to => :folder, :allow_nil => true

  validates :item, :attachment_presence => true
  validates_uniqueness_of :item_file_name, :scope => :folder_id

  scope :without_folder, where(:folder_id => nil)

  DummyFolder = Struct.new(:parent)

  def path(root = folder)
    if folder.nil?
      ""
    else
      folder.parent = folder
      folder ? folder.path(root) : nil
    end
  end

  def self.daily_mailer
    items = Item.where('created_at >= ?', 24.hours.ago)
    DailyMailer.delay_for(0.minutes).daily_notification(items.all)
  end

end






















    # result = {}
    # files = Item.all

    # names = []
    # files.each do |f|
    #   names << [f.item_file_name, f.item_file_size]
    # end

    # duplicates = names.select{|item| names.count(item) > 1}.uniq

    # dup_hash_keys = duplicates.flatten
    # name_keys = dup_hash_keys.values_at(* dup_hash_keys.each_index.select {|i| i.even?})


    # dup_files = []
    # files.each do |file|
    #   dup_files << file if duplicates.include?([file.item_file_name, file.item_file_size])
    # end

    # name_keys.each do |key|
    #   result[key] = []
    #   dup_files.each do |file|
    #     result[key] << file if file.item_file_name == key && !file.nil? && !key.nil?
    #   end
    # end
    
    # result






 