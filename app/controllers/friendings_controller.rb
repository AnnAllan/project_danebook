class FriendingsController < ApplicationController
  def index
    user = User.find(params[:user_id]) if require_valid_user
    @friends = user.friends
  end

  def create
    friending_recipient = User.find(params[:friend_id])

    if params[:user_id] == current_user.id.to_s
      flash[:error] = "Cannot friend yourself"
    elsif current_user.inverse_friends << friending_recipient
      flash[:success] = "You are now friends with #{friending_recipient.full_name}"
    else
      flash[:error] = "Not able to friend this person"
    end
    redirect_to user_posts_path(paramas[:friend_id])
  end

  def destroy
    unfriended_user = User.find(params[:friend_id])
    if current_user.inverse_friends.delete(unfriended_user)
      flash[:success] = "You are no longer friends with #{unfriended_user.full_name}"
      redirect_to user_posts_path(current_user)
    else
      flash[:error] = "Unable to unfriend this person"
    end
  end
  

end
