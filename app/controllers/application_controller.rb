class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :tree

  def tree
    @root_folders = Folder.roots
    @root_items = Item.without_folder
  end

end
