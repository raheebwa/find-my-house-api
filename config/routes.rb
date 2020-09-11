Rails.application.routes.draw do
  resource :users do
    resources :favourites, only: [:create, :destroy, :index]
  end
  resources :houses

  post "/login", to: "users#login"
  get "/profile", to: "users#profile"
end
