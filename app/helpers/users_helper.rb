module UsersHelper
  def add_post_link(user)
    return unless current_user == user

    link_to 'Add Post', new_user_post_path(user), class: 'btn btn-primary'
  end
end
