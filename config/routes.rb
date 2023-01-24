Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :users
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  scope '(:locale)' do
    resources :orders
    resources :line_items do
      patch 'decrement', on: :member
    end
    resources :carts do
      patch 'empty', on: :member
    end
    root 'store#index', as: 'store_index', via: :all
  end
end
