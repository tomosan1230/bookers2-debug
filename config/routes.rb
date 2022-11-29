Rails.application.routes.draw do
  get 'chats/show'
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get 'search' => 'searches#search'
  get 'chat/:id', to: 'chats#show', as: 'chat'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => "relationships#followings", as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :chats, only: [:create,:show]

  resources :groups, except: [:destroy]

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

end