class List < ActiveRecord::Base
  attr_accessible :item_id, :item_name, :item_size, :user_id, :folder_id

  belongs_to :folder
  belongs_to :item


  delegate :path, :to => :folder, :allow_nil => true

  def path(root = folder)
    if folder.nil?
      ""
    else
      folder.parent = folder
      folder ? folder.path(root) : nil
    end
  end

  def self.prepare_list
  	files = Item.all
    ListWorker.duplicates(files)
  end


  def self.duplicates(files)
    result = {}
    files.each do |file|
      result[file.item_name] ||= []
      result[file.item_name] << files.select{|f| f.item_size == file.item_size && file.item_name == f.item_name}
    end

    result.each do |key, val|
      result[key] = val.select{|i| val.count(i) > 1}.uniq.flatten
    end

    result = result.reject{|k,v| v.empty? }
    result
  end
  
end
