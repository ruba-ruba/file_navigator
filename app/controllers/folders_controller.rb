class FoldersController < ApplicationController

  respond_to :js, :html

  def index
    @folders = Folder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folders }
      format.js
    end
  end

  def show
    @folder = Folder.find(params[:id])

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
      format.js
    end
  end


  def create
    @folder = Folder.new(params[:folder]) 
    
    respond_to do |format|
      if @folder.save
        @folders = Folder.all
        format.html { redirect_to  @folder, notice: 'Folder was successfully created.' }
        format.json { render json: @folder, status: :created, location: @folder }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @folder = Folder.find(params[:id])
    respond_to do |format|
      if @folder.update_attributes(params[:folder])
        @folders = Folder.all
        puts 'i\'m in update'
        puts @folders
        format.html { redirect_to  @folder, notice: 'Folder was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
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
end
