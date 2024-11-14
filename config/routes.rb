Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'welcome#index'

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  get 'my_portfolio', to: 'users#my_portfolio'
end
