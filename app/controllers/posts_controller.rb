class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    @comments = @post.comments
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = t ".post_created"
      redirect_to root_url
    else
      @feed_items = []
      render "staticpages/home"
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  private
    def post_params
      params.require(:post).permit :content, :picture, :title
    end

    def correct_user
      @post = current_user.posts.find_by id: params[:id]
      redirect_to root_url if @post.nil?
    end
end
