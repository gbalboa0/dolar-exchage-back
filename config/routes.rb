Rails.application.routes.draw do
  get '/fetch_exchange_rates', to: 'dolar#fetch_exchange_rates'
  resources :dolar, controller: 'dolar', only: [:index] do
    collection do
      get 'fetch_data'
      get 'history'
    end
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
end
