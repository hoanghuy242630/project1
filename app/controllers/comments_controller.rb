class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id

    redirect_to request.referrer

    if @comment.save

    else
      flash[:danger] = "error"
    end

  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    @comment.destroy

    redirect_to request.referrer
  end

  private
  def comment_params
    params.require(:comment).permit :user_id, :post_id, :content
  end
end
