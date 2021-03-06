class ItemsController < ApplicationController
  
  include ActionView::Helpers::TextHelper 

  before_filter :authorize, only: [:edit, :update, :new, :create, :multi_create,  :destroy, :destroy_by_type]

  skip_before_filter :verify_authenticity_token, only: :create

  def index
    jpgs = Item.where("item_file_name like (?)", "%.jpg")
    @jpgs_sum = jpgs.pluck(:item_file_size).inject{|sum,x| sum + x }
    @jpgs_count = jpgs.count
    others = Item.where("item_file_name NOT LIKE (?)", "%.jpg")
    @others_sum = others.pluck(:item_file_size).inject{|sum,x| sum + x }
    @others_count = others.count
    respond_to do |format|
      format.html
      format.js
    end
  end


  def new
    @item = Item.new
    respond_to do |format|
      format.html
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
    saved = 0
    params[:item].each do |item|
      @item = current_user.items.build(:item => item, :folder_id => params[:folder_id])
      if @item.save
        saved += 1
      else
        errors << @item.item_file_name 
      end
    end
    respond_to do |format|
      if @item.folder_id.nil?
        @items = Item.without_folder
      else
        @items = Item.where(:folder_id => @item.folder_id)
      end
      if errors.empty? 
        type = 'notice'
         message = "saved #{pluralize(saved, 'file')}"
      elsif saved == 0
        type = 'alert'
        message = "#{errors} - already exists"
      else
        type = 'alert'
        message = [[errors, " - already exists"], "saved #{pluralize(saved, 'file')}"].join("\n")
      end 
      format.html { redirect_to :back, type.to_sym => message }
    end
  end  

  def create
    @item =  current_user.items.build(params[:item])
    respond_to do |format|
      if @item.save
        if @item.folder_id.nil?
          @items = Item.without_folder
        else
          @items = Item.where(:folder_id => @item.folder_id)
        end
        format.html { render :nothing => true }
        format.js { render :layout => false }
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end


  def update_duplicate_condition
    item = Item.find(params[:id])
    item.update_attribute(:duplicate, false)
    
    respond_to do |format|
      format.js
    end
  end

  def update
    @item = Item.find params[:id]

    new_file_name = "original_" + params[:item][:item_file_name]
    path = @item.item.path.split("/")
    path.pop
    path_for_file = path.join("/")
    File.rename(@item.item.path ,  path_for_file + "/" + new_file_name)

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
      if @item.folder_id.nil?
        @items = Item.without_folder
      else
        @items = Item.where(:folder_id => @item.folder_id)
      end
      format.js
    end
  end

  def destroy_by_type
    Item.destroy(params[:items])
    if params[:folder_id]
      @items = Item.where(:folder_id => params[:folder_id])      
    else
      @items = Item.without_folder
    end
    respond_to do |format|
      format.js
    end
  end



end
