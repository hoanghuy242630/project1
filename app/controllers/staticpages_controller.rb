class StaticpagesController < ApplicationController
  def show
    render template: "staticpages/#{params[:page]}"
  end

  def home
    if logged_in?
      @post = current_user.posts.build
      @feed_items = Post.feed(current_user.id).paginate page: params[:page],
        per_page: Settings.users.per_page
    end
  end
end
