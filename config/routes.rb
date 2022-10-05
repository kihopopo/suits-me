Rails.application.routes.draw do

  get "search" => "public/searches#search"
  namespace :admin do
    get '/' => 'homes#top'
    resources :genres
    resources :items do
      resources :comments, only: [:destroy]
    end
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
    resources :colors
    resources :items do
      resources :comments, only: [:create, :edit, :destroy]
    end
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/confirm' => 'orders#confirm_error'
    get '/orders/complete' => 'orders#complete'
    resources :orders
    resources :post_images do
      resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    end
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
