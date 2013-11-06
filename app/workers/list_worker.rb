class ListWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def self.duplicates(files)
    result = {}
    files.each do |file|
      result[file.item_file_name] ||= []
      result[file.item_file_name] << files.select{|f| f.item_file_size == file.item_file_size && file.item_file_name == f.item_file_name}
    end

    result.each do |key, val|
      result[key] = val.select{|i| val.count(i) > 1}.uniq.flatten
    end
    result = result.reject{|k,v| v.empty? }
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
      List.create(item_id: file.id, item_name: file.item_file_name, item_size: file.item_file_size, user_id: file.user_id, folder_id: file.folder_id)
    end
  end


end

