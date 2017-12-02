class CommentsController < ApplicationController
  before_action :store_referer

  def create
    @comment = Comment.new(params_list)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "comment created"
    else
      flash[:error] = "comment could not be created"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if (current_user.id == @comment.user_id) && @comment.destroy
      flash[:success] = "Comment was deleted"
    else
      flash[:error] = "Comment could not be deleted"
    end
  end

  private
  def params_list
    params.require(:comment).permit(:body, :id, :commentable_type, :commentable_id)
  end
end
