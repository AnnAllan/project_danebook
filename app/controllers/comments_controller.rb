class CommentsController < ApplicationController
  before_action :store_referer

  def create
    @comment = Comment.create(params_list)
    puts "#{@comment.content} is comment +++++++++++++++"
    @comment.user_id = current_user.id
    puts "#{@comment.user_id} is com user Id ++++++++++++++++++++++"
    puts "#{@comment.save} is status of save ++++++++++++++++++++"
    if @comment.save
      flash[:success] = "comment created"
    else
      flash[:error] = "comment could not be created"
    end
    redirect_to user_posts_path(current_user.id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if (current_user.id == @comment.user_id) && @comment.destroy
      flash[:success] = "Comment was deleted"
    else
      flash[:error] = "Comment could not be deleted"
    end
    redirect_back(fallback_location: user_posts_path(current_user.id))
  end

  private
  def params_list
    params.require(:comment).permit(:content, :id, :commentable_type, :commentable_id)
  end
end
