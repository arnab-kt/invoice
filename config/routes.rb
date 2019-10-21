Rails.application.routes.draw do

  resources :brands, except: [:show]
  resources :categories
  resources :uoms

  root "home#index"
end
