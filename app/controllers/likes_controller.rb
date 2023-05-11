class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(author: current_user)

    if @like.save
      redirect_back(fallback_location: @post)
    else
      flash[:error] = 'There was an error liking the post'
      redirect_to @post
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.post

    @like.destroy
    redirect_back(fallback_location: @post)
  end
end
