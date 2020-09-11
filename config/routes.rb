# frozen_string_literal: true

Rails.application.routes.draw do
  resource :users do
    resources :favourites, only: %i[create destroy index]
  end
  resources :houses

  post '/login', to: 'users#login'
  get '/profile', to: 'users#profile'

  # documentation
  mount Raddocs::App => '/docs'
end
