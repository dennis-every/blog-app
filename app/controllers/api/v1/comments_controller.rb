class Api::V1::CommentsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate, only: :index

  def index
    post = Post.find(params[:post_id])
    @comments = Comment.where(post:)

    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.author = @authorized_user

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :text)
  end
end
