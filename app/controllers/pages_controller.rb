class PagesController < ApplicationController
  respond_to :html
  before_filter :require_user, except: [:index, :show]

  expose(:themes) { 'textura02 naranja group' }
  expose(:pages) { current_group.pages.all }
  expose(:page)

  def index
    respond_with pages
  end

  def show
    respond_with page
  end

  def new
    authorize! :new, page
  end

  def edit
    respond_with page
  end

  def create
    page.user = current_user
    page.group = current_group
    authorize! :create, page
    flash[:notice] = t('notice.pages.created') if page.save
    respond_with page
  end

  def update
    flash[:notice] = t('notice.pages.updated') if page.update_attributes(params[:page])
    respond_with page
  end

  def destroy
    authorize! :delete, page
    flash[:notice] = 'Borrado' if page.destroy
    respond_with page, location: pages_path
  end

end
