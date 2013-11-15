require 'rubygems'
require 'zip'

class FoldersController < ApplicationController

  helper_method :folder_sort_column, :item_sort_column, :sort_direction

  respond_to :js, :html

  before_filter :authorize, only: [:edit, :update, :new, :create, :destroy]

  def index
    show_roots

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folders }
      format.js
    end
  end

  def show_roots
    folders = Folder.order(folder_sort_column + ' ' + sort_direction)
    @items = Item.without_folder.order(item_sort_column + ' ' + sort_direction)
    @folders = []
    folders.each do |folder|
      if folder.root? 
        @folders << folder
      end
    end
  end

  def drop
  end

  def folder_info(folder = nil, sub_folders = [], items = [])
    if folder.nil?
      @folder = Folder.find params[:id]
    else
      @folder = folder
    end
    @folder.children.each do |child|
      items << @folder.items 
      sub_folders << folder_info(child, sub_folders, items)
    end
    @sub_folders_count = sub_folders.count
    @items_count = items.compact.flatten.count
  end


  def download_file
    file = Item.find(params[:item])
    input_filenames = [file]

    folder = Rails.root.to_s
    zipfile_name = "#{Rails.root}/archives/#{file.item_file_name}.zip"

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      input_filenames.each do |filename|
        zipfile.add(filename.item_file_name.to_s, folder + '/public' + filename.item.url.to_s)
      end
    end
    send_file zipfile_name
  end


  def download_folder
    folder = Folder.find(params[:folder])
    input_folder_name = [folder.title]

    path = Rails.root

    zip_file_name = "#{Rails.root}/archives/#{folder.title}_#{Time.now.to_i}.zip"

    Zip::File.open(zip_file_name, Zip::File::CREATE) do |zip_file|
      create_folder_tree(zip_file, folder, folder)
    end
    send_file zip_file_name
  end

  def create_folder_tree(zip_file, folder, root)
    create_files_for_zip(zip_file, folder, root)
    folder.children.each do |sub_folder|
      zip_file.mkdir([sub_folder.path(root), sub_folder.title].join('/'), 0777)
      create_folder_tree(zip_file, sub_folder, root)
    end
  end

  def create_files_for_zip(zip_file, folder, root)
    input_filenames = folder.items.flatten
    input_filenames.each do |file|
      destination_to_file = File.expand_path('../..', zip_file.to_s) + '/public' + file.item.url
      file_name = [file.path(root), file.item_file_name].compact.join('/')
      zip_file.add(file_name, destination_to_file)
    end
  end

  def show
    @folder = Folder.find(params[:id])
    @folders = @folder.children.order(folder_sort_column + ' ' + sort_direction)
    @items = @folder.items.order(item_sort_column + ' ' + sort_direction)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @folder }
      format.js
    end
  end

  def new
    @folder = Folder.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @folder }
      format.js
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = Folder.find(params[:id])
    respond_to do |format|
      format.html 
      format.json
      format.js { render }
    end
  end


  def create
    @folder = current_user.folders.build(params[:folder]) 
    
    respond_to do |format|
      if @folder.save
        if @folder.ancestry.present?
          @folder = @folder.parent
          @folders = @folder.children
          @items = @folder.items
        else
          show_roots
        end
        format.html { redirect_to  @folder, notice: 'Folder was successfully created.' }
        format.json { render json: @folder, status: :created, location: @folder }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    @folder = Folder.find(params[:id])
    respond_to do |format|
      if @folder.update_attributes(params[:folder])
        if @folder.ancestry.present?
          @folder = @folder.parent
          @folders = @folder.children
          @items = @folder.items
        else
          show_roots
        end
        format.html { redirect_to  @folder, notice: 'Folder was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @folder = Folder.find(params[:id])
    @folder.destroy

    respond_to do |format|
      format.js
    end
  end

  def destroy_multiple
    Folder.destroy(params[:folders]) if params[:folders].present?
    Item.destroy(params[:items]) if params[:items].present?

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
      format.js
    end
  end

  private

    def correct_user
      @folder = Folder.find(params[:id])
      redirect_to root_path unless current_user == @folder.user || admin?
      flash.now[:notice] = "not permitted"
    end

    private

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

    def folder_sort_column
      Folder.column_names.include?(params[:sort]) ? params[:sort] : "title"
    end

    def item_sort_column
      Item.column_names.include?(params[:items_sort]) ? params[:items_sort] : "item_file_name"
    end

end
