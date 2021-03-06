class LikesController < ApplicationController
  before_action :store_referer

  def create
    @like = Like.new(safe_like_params)
    @like.user_id = current_user.id
    if @like.save
      flash[:success] = "Like created"
    else
      flash[:error] = "Unable to create Like"
    end
  end

  def destroy
    @like = current_user.match_like(safe_like_params)
    if current_user.id == @like.user_id && @like.destroy
      flash[:success] = "Unliked"
      redirect_to user_post_path(current_user.id)
    else
      flash[:error] = "Unable to unlike"
    end
  end

  private
    def safe_like_params
      params.require(:like).permit(:likable_type, :likable_id, :method, :id)
    end

end
