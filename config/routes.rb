Rails.application.routes.draw do

  namespace :admin do
    get '/' => 'homes#top'
    get 'search' => 'homes#search', as: 'search'
    resources :genres
    resources :items
    resources :customers
    resources :orders
    resources :order_details
  end

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    resources :addresses
    resources :items
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/confirm' => 'orders#confirm_error'
    get '/orders/complete' => 'orders#complete'
    resources :orders
  end

  root to: "public/homes#top"
  get '/about' => 'public/homes#about'
  get 'customers/my_page' => 'public/customers#show'
  get 'customers/information/edit' => 'public/customers#edit'
  patch 'customers/information' => 'public/customers#update'
  get 'customers/unsubscribe' => 'public/customers#unsubscribe'
  patch 'customers/withdraw' => 'public/customers#withdraw'

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
