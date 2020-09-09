Rails.application.routes.draw do
  resource :users, only: [:create, :delete]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
