class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:show, :destroy]
  before_action :correct_user,   only: :destroy 
  
  def index    
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @user = User.find(params[:id])
  end
  

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to root_url    
  end
  

    private

    #bfore action
    def correct_user
      @user = User.find(params[:id])                                            #URLに含まれている情報からparams[:id]のユーザー情報を取得
      redirect_to(root_url) unless current_user?(@user)                         #アクセスしたページのユーザーと、current_userが同じでなければルートページにリダイレクト
    end
    
    def correct_user
      @user = User.find(params[:id])                                            #URLに含まれている情報からparams[:id]のユーザー情報を取得
      redirect_to(root_url) unless current_user?(@user)                        #アクセスしたページのユーザーと、current_userが同じでなければルートページにリダイレクト
    end
end