Dashboard::Engine.routes.draw do
  resources :examples
  get "/welcome", to: "home#index"
end
