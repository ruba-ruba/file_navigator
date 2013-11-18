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
    @folder = current_user.folders.build(params[:folders2]) 
    if @folder.save
      render json: 'success'
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  def update
    @folder = Folder.find(params[:id])
    p = {}
    p[:title] = params[:folders2][:title]
    p[:description] = params[:folders2][:description]
    if @folder.update_attributes(p)
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
