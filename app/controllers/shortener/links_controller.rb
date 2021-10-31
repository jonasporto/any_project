class Shortener::LinksController < ApplicationController
  before_action :ensure_session_loaded!, only: :show
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def new
    @link = Shortener::Link.new
  end

  def create
    @link = Shortener::Link.new(link_params)

    if @link.save
      redirect_to shortener_link_info_path(@link.token)
    else
      render :new
    end
  end

  def show
    @link = Shortener::Link.find_by!(token: params[:token])

    @link.visitors.create!(visitor_params)

    redirect_to @link.long_url
  end

  private

  def link_params
    params.require(:shortener_link).permit(:long_url)
  end

  def visitor_params
    {
      ip_address: request.remote_ip,
      referrer: request.referrer,
      session_id: request.session.id 
    }
  end
end
