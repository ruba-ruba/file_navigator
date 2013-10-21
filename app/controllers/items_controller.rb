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
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
      format.js
    end
  end


  def edit
    @item = Item.find params[:id]
    respond_to do |format|
      format.html
    end
  end

  def create
    @item =  Item.new(params[:item])

    respond_to do |format|
      if @item.save
        if @item.folder_id.nil?
          @items = Item.without_folder
        else
          @items = Item.where(:folder_id => @item.folder_id)
        end
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
    @item =  Item.find params[:id]

    respond_to do |format|
      if @item.update_attributes(params[:item])
        if @item.folder_id.nil?
          @items = Item.without_folder
        else
          @items = Item.where(:folder_id => @item.folder_id)
        end
        format.html { redirect_to :back, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
        format.js
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

  def destroy_multiple
    Item.destroy(params[:items])

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
      format.js
    end
  end

end
