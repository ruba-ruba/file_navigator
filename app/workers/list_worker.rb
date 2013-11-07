class ListWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def self.duplicates(files)
    result = []
    files.each do |file|
      result << files.select{|f| f.item_file_size == file.item_file_size && file.item_file_name == f.item_file_name && file.duplicate ==  true}
    end
    create_list(result)
  end

  def self.create_list(files)
    List.delete_all
    files.uniq.flatten.each do |file|
      List.create(item_id: file.id, item_file_name: file.item_file_name, item_file_size: file.item_file_size, user_id: file.user_id, folder_id: file.folder_id)
    end
  end


end

