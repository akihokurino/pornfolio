require 'sidekiq/web'
Pornofolio::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  apipie unless Rails.env.production?
  scope '/api' do

    resources :posts, format: 'json' do
      collection do
        get 'mindex'
      end
    end
    resources :post_comments, format: 'json'
    resources :user_favorites, format: 'json'
    resources :post_likes, format: 'json'
    resources :ads, only: [:index, :create], format: 'json'
    resources :contacts, only: [:create], format: 'json'
    resources :categories, only: [:index], format: 'json'
    resources :tags, only: [:index], format: 'json'

    post 'beta' => 'beta#auth', :as => :beta, format: 'json'
    get 'error' => 'errors#auth_failed', format: 'json'

    get 'xvideos/thumbnails' => 'xvideos#thumbnails', format: 'json'
    get 'asgs/thumbnails' => 'asgs#thumbnails', format: 'json'
  end
  match '/*path' => 'application#cors_preflight_check', :via => :options
  match '*not_found' => 'application#error_404', :via => [:get, :post], format: 'json'
end
