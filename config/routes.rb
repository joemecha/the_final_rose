Rails.application.routes.draw do
  root to: "bachelorettes#index"

  resources :bachelorettes, only: [:index, :show] do
    resources :contestants, only: [:index, :show]
  end

  resources :outings, only: [:show]
end
