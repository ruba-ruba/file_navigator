class List < ActiveRecord::Base
  attr_accessible :item_id, :item_name, :item_size

  def self.prepare_list
    ListWorker.duplicates
  end
  
end
