Rails.application.routes.draw do
  root      'home#index'
  get       '/auth/:provider/callback', to: 'sessions#create'
  delete    '/logout',                  to: 'sessions#destroy'
  resources :users,                     only: [:index,:show, :destroy]
  resources :schedule,                  only: [:show,:new,:create, :destroy] do     
    resources :time_schedules ,         only: [:new,:create, :destroy]
  end
end