Rails.application.routes.draw do

  get 'purchases/index'
  get 'purchases/show'
  get 'purchases/new'
  get 'purchases/edit'
  resources :brands, except: [:show, :destroy]
  resources :categories, except: [:show, :destroy]
  resources :uoms, except: [:show, :destroy]
  resources :products, except: [:show, :destroy]

  root "home#index"
end
