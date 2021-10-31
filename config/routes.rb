Rails.application.routes.draw do
  namespace :shortener do
    resource :links, only: [:create]
    get 'links', to: redirect('/')
  end

  get '/:token/info', to: 'shortener/links/infos#show', as: :shortener_link_info
  get '/:token', to: 'shortener/links#show', as: :shortener_link


  root to: 'shortener/links#new'
end
