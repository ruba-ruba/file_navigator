class ItemsController < ApplicationController


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
      format.js
    end
  end

  def multi_create
    errors = []
    params[:item].each do |item|
      @item = Item.new(:item => item, :folder_id => params[:folder_id])
      if @item.save
        #
      else
        errors << "#{@item.item_file_name} aleready exist" 
      end
    end
    respond_to do |format|
      if @item.folder_id.nil?
        @items = Item.without_folder
      else
        @items = Item.where(:folder_id => @item.folder_id)
      end
      format.html { redirect_to :back}
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
        format.html { render :nothing => true }
        format.json { render json: @item, status: :created, location: @item }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.js
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
        format.js
      end
    end
  end

  def destroy
    @item = Item.find params[:id]
    @item.destroy

    respond_to do |format|
      # format.html { redirect_to :back, notice: 'Item was successfully deleted.' }
      # format.json { head :no_content }
      format.js
    end
  end

  def destroy_by_type
    Item.destroy(params[:items])
    respond_to do |format|
      format.js
    end
  end


end
