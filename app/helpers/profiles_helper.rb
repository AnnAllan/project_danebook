module ProfilesHelper
  def edit_link_display
    if current_user.id == @user.id
      str = link_to "Edit", edit_user_profile_path(current_user)
      str.html_safe
    end
  end
end
