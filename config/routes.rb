Rails.application.routes.draw do
  get 'home/index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  root 'home#index'
end