class FoldersController < ApplicationController

  def index
    @folders = Folder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folders }
    end
  end

  def show
    @folder = Folder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @folder }
    end
  end

  def new
    @folder = Folder.new
    session[:prev_url] = request.referer
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @folder }
      format.js
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = Folder.find(params[:id])
    session[:prev_url] = request.referer
  end


  def create
    @folder = Folder.new(params[:folder])

    respond_to do |format|
      if @folder.save
        format.html { redirect_to session[:prev_url], notice: 'Folder was successfully created.' }
        format.json { render json: @folder, status: :created, location: @folder }
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
        format.html { redirect_to  session[:prev_url], notice: 'Folder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @folder = Folder.find(params[:id])
    @folder.destroy

    # respond_to do |format|
    #   format.html { redirect_to :back, notice: 'Folder was successfully deleted.' }
    #   format.json { head :no_content }
    # end
  end
end
