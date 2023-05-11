module LikesHelper
  def like_link(post)
    if current_user.likes?(post)
      button_to 'Unlike', like_path(current_user.like_for(post)), method: :delete, class: 'btn btn-primary'
    else
      button_to 'Like', post_likes_path(post), class: 'btn btn-primary'
    end
  end
end
