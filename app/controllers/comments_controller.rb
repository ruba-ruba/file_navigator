class CommentsController < ApplicationController

  before_filter :load_commentable

  before_filter :authorize, only: [:edit, :update, :new, :create, :destroy]

  def index
    #binding.pry
    #@comments = @commentable.comments
    @comments = Comment.where(:commentable_id => @commentable.id).scoped
  end

  def new
    @comment = @commentable.comments.new
    respond_to(:html, :js)
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    respond_to do |format|
      if @comment.save
        @comments = @commentable.comments
        flash[:notice] = "Successfully saved comment."
        format.js
      else
        format.json { render json: @comment, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
    end   
  end


  private

    def load_commentable
      resource, id = request.path.split('/')[1, 2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end




end
