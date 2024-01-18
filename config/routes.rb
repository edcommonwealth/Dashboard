Dashboard::Engine.routes.draw do
  resources :districts do
    resources :schools, only: %i[index show] do
      resources :overview, only: [:index]
      resources :categories, only: [:show], path: "browse"
      resources :analyze, only: [:index]
    end
  end
  get "/welcome", to: "home#index"
end
