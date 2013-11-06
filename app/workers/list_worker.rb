class ListWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def self.duplicates
    result = {}
    files = Item.all

    names = []
    files.each do |f|
      names << [f.item_file_name, f.item_file_size]
    end

    duplicates = names.select{|item| names.count(item) > 1}.uniq

    dup_hash_keys = duplicates.flatten
    name_keys = dup_hash_keys.values_at(* dup_hash_keys.each_index.select {|i| i.even?})


    dup_files = []
    files.each do |file|
      dup_files << file if duplicates.include?([file.item_file_name, file.item_file_size])
    end

    name_keys.each do |key|
      result[key] = []
      dup_files.each do |file|
        result[key] << file if file.item_file_name == key && !file.nil? && !key.nil?
      end
    end
    
    result

    remove_previouse

    create_list(result)
  end

  def self.remove_previouse
    List.delete_all
  end

  def self.create_list(data)
    array = data.values.flatten
    array.each do |file|
      List.create(item_id: file.id, item_name: file.item_file_name, item_size: file.item_file_size)
    end
  end


end

