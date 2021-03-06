class UsersController < ApplicationController
  respond_to :html

  expose(:themes) { 'textura04 azul_gris' }
  expose(:users) { User.all }
  expose(:user)
  expose(:message) { Message.new(resource: user) }

  def index
    breadcrumb_for_users
    respond_with users
  end

  def show
    if params[:id] != user.to_param
      redirect_to user, status: 301
    else
      authorize! :show, user
      breadcrumb_for_user(user)
      respond_with user
    end
  end

  def new
    respond_with user
  end

  def edit
    authorize! :update, user
    respond_with user
  end

  def create
    if user.save
      flash[:notice] = t('users.notices.created')
      login_user(user)
    end
    respond_with user
  end

  def update
    authorize! :update, user
    flash[:notice] = t('users.notices.updated') if user.save
    respond_with user
  end

  def enter
    return if Rails.env.production? && !current_user.admin?
    user = User.find params[:id]
    login_user(user, bypass: true)
    redirect_to root_path
  end
end
