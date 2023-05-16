class UsersController < ApplicationController
  def index
    @users = User.order(id: :asc)
  end

  def show
    @user = User.includes(:posts).find(params[:id])
    @likes = @user.likes.includes(:post).index_by(&:post_id)
    @liked_post_ids = @likes.keys
  end
end
