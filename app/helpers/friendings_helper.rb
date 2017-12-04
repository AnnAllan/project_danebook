module FriendingsHelper

  def friend_unfriend_button(friend_id = parama[:user_id])
    friended = currnt_user.inverse_friends.findy_by_id(friend_id)
    if friended
      link_to "Remove Friend", friending_path(friended.id, friend_id: friend), method: :delete, id: "friending"
    else
      link_to "Add Friend", friendings_path(friend_id: friend_id), mthod: :post, id: "friending"
    end
  end

  def friend_num
    num = User.find(params[:user_id]).friends.size
    num > 0 ? "(#{num.to_s})" : ""
  end

  def friends_widget
    if @user.friends.any?
      render partial: 'friend_panel', locals: {frineds: @user.friends.shuffle}
    end
  end
end
