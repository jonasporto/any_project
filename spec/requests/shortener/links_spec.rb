require 'rails_helper'

RSpec.describe Shortener::LinksController, type: :request do
  let(:long_url) { 'https://example.com/any/path?with=query&string=values' }

  describe 'GET /' do
    it 'defines shortener/links#new as root', type: :routing do
      expect(get '/').to route_to('shortener/links#new')
    end

    it 'render the correct template with proper instance variables' do
      get root_path
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /:token' do
    it 'redirects a token to the long url' do
      link = Shortener::Link.create(long_url: long_url)

      get shortener_link_path(link.token)
      expect(response).to redirect_to long_url
    end

    it '404 not found for not existing items' do
      get shortener_link_path('notExisting')
      expect(response).to have_http_status(404)
    end
  end

  describe 'POST /' do
    it 'does not create links for blocklisted domains' do
      post shortener_links_path, params: { shortener_link: { long_url: 'http://localhost:3000/anylink' } }
      expect(response).to render_template(:new)
    end

    it 'does redirect to the long url' do
      post shortener_links_path, params: { shortener_link: { long_url: long_url } }
      last_link = Shortener::Link.last

      expect(response).to redirect_to "/#{last_link.token}/info"
    end
  end
end
