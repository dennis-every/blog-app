class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_user, only: :index
  before_action :set_likes, only: :index

  def index
    @posts = @user&.posts&.includes(:likes, last_five_comments: :author)&.order(created_at: :asc)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @user = @post.author
    @likes = @user.likes.includes(:post).index_by(&:post_id)
    @liked_post_ids = @likes.keys
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post.author
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    user = @post.author

    @post.destroy
    redirect_back(fallback_location: user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_likes
    @likes = @user&.likes&.includes(:post)&.index_by(&:post_id)
    @liked_post_ids = @likes&.keys
  end

  def post_params
    params.require(:post).permit(:author_id, :title, :text)
  end
end
