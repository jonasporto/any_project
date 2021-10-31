module ResponseErrors
  def render_404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found }
      format.any  { head :not_found }
    end
  end
end
