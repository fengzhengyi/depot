Rails.application.routes.draw do
  resources :orders
  resources :line_items do
    patch 'decrement', on: :member
  end
  resources :carts do
    patch 'empty', on: :member
  end
  root 'store#index', as: 'store_index'
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
