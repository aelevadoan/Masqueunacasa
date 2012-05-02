class PostsController < ApplicationController
  respond_to :html
  before_filter :load_subdomain_group

  expose(:posts) { current_group.posts }
  expose(:post)

  def index
    respond_with posts
  end

  def show
    respond_with post
  end

  def new
    authorize! :new, Post
  end

  def edit
    respond_with post
  end

  def create
    post.user = current_user
    post.group = current_group
    authorize! :create, post
    flash[:notice] = t('notice.posts.created') if post.save
    respond_with post
  end

end
