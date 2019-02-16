class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
   include ApplicationHelper
   include SessionsHelper
   include TimeSchedulesHelper
   
     private
  
    def logged_in_user                                                          #ログイン済みユーザーかどうか確認
      unless logged_in?                                                         #logged_in?がfalseの場合
        flash[:danger] = "ログインしてください"                                 #失敗フラッシュを表示
        redirect_to root_url                                                   #ログインページへ
      end
    end
end
