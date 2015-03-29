class SiteMapsController < ApplicationController
  def index
    @site = SiteMap.new
    @sites = SiteMap.where(id: sites_ids_from_session)
  end

  def show
    @site = SiteMap.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render xml: @site.xml }
      format.json { render json: @site }
    end
  end

  def new
    @site = SiteMap.new
  end

  def create
    @site = SiteMap.new(site_map_params)
    if @site.save
      add_site_to_session(@site.id)
      SiteMapBuilderWorker.perform_async(@site.url, @site.id)
      redirect_to(site_map_path(@site))
    else
      flash.now[:error] = 'Enter valid url with scheme'
      redirect_to(site_maps_path)
    end
  end

  def destroy
    map = SiteMap.find(params[:id])
    if map.destroy
      flash[:notice] = 'Destroyed site_map'
    else
      flash[:notice] = 'Problem destroying site_map'
    end
    redirect_to site_maps_path
  end

  private

  def sites_ids_from_session
    ids = session[:rendered_pages]
    ids = [] if ids.nil?
    ids
  end

  def add_site_to_session(id)
    session[:rendered_pages] ||= []
    session[:rendered_pages] << id
  end

  def site_map_params
    params.require(:site_map).permit(:url)
  end
end
