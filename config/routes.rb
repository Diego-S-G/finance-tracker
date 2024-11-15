Rails.application.routes.draw do
  resources :user_stocks, only: [:create]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'welcome#index'

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy' #não é o ideal mas infelizmente problemas estão ocorrendo e estou priorizando meu aprendizado
  end

  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#if_api_usage_limit'
  # get 'search_stock', to: 'stocks#search'
end
