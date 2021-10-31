class Shortener::Links::InfosController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def show
    @link = Shortener::Link.find_by!(token: params[:token])
  end
end
