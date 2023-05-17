class PostsController < ApplicationController
  def index
    @user = current_user
    @likes = @user.likes.includes(:post).index_by(&:post_id)
    @liked_post_ids = @likes.keys
    @posts = @user.posts.includes(:likes, last_five_comments: :author).order(created_at: :asc)
    @posts_count = @posts.size
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

  private

  def post_params
    params.require(:post).permit(:author_id, :title, :text)
  end
end
