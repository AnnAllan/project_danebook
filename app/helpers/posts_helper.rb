module PostsHelper

  def post_owner_link_option(post)
    puts "#{current_user.id} is current_user id"
    puts "#{post.user_id} is post user id"
    if current_user.id == post.user_id
      link_to "Delete", user_post_path(current_user, post), method: :delete, :remote => true    end
  end

  def post_form_display
    puts "this is now the problem again"
    render 'new_post_form' if current_user.id == params[:user_id].to_i
  end
end
