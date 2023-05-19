module UsersHelper
  def display_users(users)
    if users.any?
      content_tag :div do
        concat content_tag(:h1, 'List of users')
        concat content_tag(:ul, render(users))
      end
    else
      content_tag :p, 'There are no users'
    end
  end

  def add_post_link(user)
    return unless current_user == user

    link_to 'Add Post', new_user_post_path(user), class: 'btn btn-primary'
  end

  def display_auth_token(user)
    return unless can? :read, user

    "Auth token: #{user.auth_token}"
  end
end
