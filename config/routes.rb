Rails.application.routes.draw do
  root 'home#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout',               to: 'sessions#destroy'
  resources :users,           only: [:index,:show, :destroy]
  resources :day_of_the_week, only: [:show,:create, :destroy]
  
end