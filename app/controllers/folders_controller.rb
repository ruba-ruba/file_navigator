require 'rubygems'
require 'zip'

class FoldersController < ApplicationController

  respond_to :js, :html

  before_filter :authorize, only: [:edit, :update]

  def index
    show_roots

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folders }
      format.js
    end
  end

  def drop
  end

  def folder_info
    folder = Folder.find params[:id]
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
    #binding.pry
    folder = Folder.find(params[:folder])
    input_foldername = [folder.title]

    path = Rails.root.to_s

    zipfile_name = "#{Rails.root}/archives/#{folder.title}_#{Time.now.to_i}.zip"

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      folder.children.each do |child|
        #zipfile.mkdir(child.title, permissionInt = 0777)
        meth(zipfile, child)
      end
    end
    send_file zipfile_name
  end

  def meth(zipfile, child)
      child.children.each do |sub_child|
        zipfile.mkdir("#{child.title}/"+ sub_child.title, permissionInt = 0777)
        meth(zipfile ,sub_child)
      end
  end

  def show
    @folder = Folder.find(params[:id])
    @folders = @folder.children
    @items = @folder.items

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

  def show_roots
    folders = Folder.all
    @items = Item.without_folder
    @folders = []
    folders.each do |folder|
      if folder.root? 
        @folders << folder
      end
    end
  end


  def create
    @folder = Folder.new(params[:folder]) 
    
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
end
