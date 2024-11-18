Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'welcome#index'

  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#if_api_usage_limit'
  # get 'search_stock', to: 'stocks#search'

  resources :friendships, only: [:create, :destroy]
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search_user_friend'

  resources :users, only: [:show], :constraints => { :id => /[0-9|]+/ } #um estudante disse que se não fizer assim pode dar conflito com devise (edit creio)
end
