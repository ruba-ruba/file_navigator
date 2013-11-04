class CommentsController < ApplicationController

  before_filter :load_commentable

  before_filter :authorize, only: [:edit, :update, :new, :create, :destroy]

  before_filter :correct_user, :only => :destroy

  def index
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
        @comments = Comment.where(:commentable_id => @commentable.id).scoped  
        format.js
        else
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

    def correct_user
      @comment = Comment.find(params[:id])
      redirect_to root_path unless current_user == @comment.user || admin?
      flash.now[:notice] = "not permitted"
    end


end
