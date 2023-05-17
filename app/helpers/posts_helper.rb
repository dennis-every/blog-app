module PostsHelper
  def delete_link(post)
    return unless can? :destroy, post

    button_to 'Delete', post_path(post), method: :delete, class: 'btn btn-danger'
  end
end
