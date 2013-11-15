class Folders2Controller < ApplicationController

  def index
    @folders = Folder.all
    render :json => @folders.to_json
  end

  def show
    @folder = Folder.find(params[:id])
    render :json => @folder.to_json
  end

  def new
    @car = Folder.new
    render :json => {status: 'ok'}
  end

  def edit
    @car = Folder.find(params[:id])

  end

  def create
    @folder = current_user.folders.build(params[:folder]) 
    if @folder.save
      render json: 'success'
    else
      render json: @fodler.errors, status: :unprocessable_entity
    end
  end

  def update
    @folder = Folder.find(params[:id])
    if @folder.update_attributes(params[:folder])
      render json: 'updated'
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @folder = Folder.find(params[:id])
    @folder.destroy
    render :json => "folder #{@folder.title} was deleted"
  end

end
