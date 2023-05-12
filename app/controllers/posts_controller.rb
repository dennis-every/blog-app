class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
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
