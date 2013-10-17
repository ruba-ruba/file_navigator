class ItemsController < ApplicationController

  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end


  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end


  def new
    if params[:folder_id]
      @folder = Folder.find params[:folder_id]
      @item = @folder.items.build
    else
      @item = Item.new
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
      format.js
    end
  end


  def edit
    @folder = Folder.find params[:folder_id]
    @item =  @folder.items.find params[:id]
  end

  def create
    @folder = Folder.find params[:folder_id]
    @item =  @folder.items.build params[:item]


    respond_to do |format|
      if @item.save
        @folder = Folder.find params[:folder_id]
        format.html { redirect_to folder_path(@item.folder_id), notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @folder = Folder.find params[:folder_id]
    @item =  @folder.items.find params[:id]

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to folder_path(@item.folder_id), notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # @folder = Folder.find params[:folder_id]
    @item = Item.find params[:id]
    @item.destroy

    respond_to do |format|
      # format.html { redirect_to :back, notice: 'Item was successfully deleted.' }
      # format.json { head :no_content }
      format.js
    end
  end
end
