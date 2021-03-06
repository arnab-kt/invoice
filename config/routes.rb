Rails.application.routes.draw do

  resources :brands, except: [:show, :destroy]
  resources :categories, except: [:show, :destroy]
  resources :uoms, except: [:show, :destroy]
  resources :products, except: [:show, :destroy]
  resources :purchases
  resources :sales
  root "home#index"
end
