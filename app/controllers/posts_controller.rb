class PostsController < ApplicationController
  before_action :require_valid_user
  before_action :require_current_user, except: [:index]

  def index
    @post = Post.new
    @user = User.includes(:profile,
                          posts: [:likes, :comments],
                          comments: [:likes, :user]).find(params[:user_id])
    @posts = @user.posts.order("created_at DESC")
    @profile = @user.profile
  end

  def create
    @post = Post.new(safe_post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "Created new post!"
    else
      flash.now[:error] = "Failed to Create post!"
    end
    redirect_to user_posts_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    if (current_user.id == @post.user_id) && @post.destroy
      flash[:success] = "Post deleted"
    else
      flash[:error] = "Post could not be delted"
    end
    redirect_to user_posts_path(current_user)

  end

  private
    def safe_post_params
      params.require(:post).permit(:id, :content, :user_id)
    end
end
