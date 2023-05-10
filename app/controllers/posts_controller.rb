class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.last_3_posts.includes(:comments)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
  end
end
