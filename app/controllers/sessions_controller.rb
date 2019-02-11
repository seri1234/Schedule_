class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    
    if user
      session[:user_id] = user.id
      flash[:success] = "ユーザー認証が完了しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "ユーザー認証が失敗しました。"
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    flash[:success] = "ログアウトしました。"
    redirect_to root_path
  end
  
end