Rails.application.routes.draw do
  root 'home#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout',               to: 'sessions#destroy'
  resources :users,           only: [:index,:show, :destroy]
  resources :schedule       , only: [:show,:new,:create, :destroy] do      #schedule_path(schedule)  GET     /schedule/:id showアクション
                                                                                #schedule_path(schedule)  post    /posts(posts_path)アクセスcreatアクション.予定を投稿する。
                                                                                #schedule_path(schedule)         delete  /users/:id   destroyアクション  予定情報を削除
    resources :time_schedules , only: [:new,:create, :destroy]
  end
end