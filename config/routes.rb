Dashboard::Engine.routes.draw do
  get "/welcome", to: "home#index"
end
