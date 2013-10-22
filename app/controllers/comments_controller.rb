class CommentsController < ApplicationController

  def index
    @commentable = find_commentable
    @comments = @commentable.comments
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])

    respond_to do |format|
      if @comment.save
        @commentable = find_commentable
        @comments = @commentable.comments
        flash[:notice] = "Successfully saved comment."
        format.js
      else
        format.json { render json: @comment, status: :unprocessable_entity }
        format.js
      end

    end

  end


  private

    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end




end
