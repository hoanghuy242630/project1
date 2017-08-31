class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end

    if @comment.save

    else
      flash[:danger] = "error"
    end

  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit :user_id, :post_id, :content
  end
end
