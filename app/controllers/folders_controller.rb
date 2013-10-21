class FoldersController < ApplicationController

  respond_to :js, :html

  def index
    show_roots

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folders }
      format.js
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
      format.js
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
