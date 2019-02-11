module SessionsHelper

  def current_user                                                              #viewにおいてログイン判定や、ログインユーザー情報を取得するのに使う
    if session[:user_id]                                                        #もしsession[:use_id]に値があれば（同時にuser_idに代入）
      @current_user ||= User.find_by(id: session[:user_id])                     #@current_userに値があればそれを返し、無ければuser.idのユーザ情報を@curretn_userに代入して返す
    end
  end
    
  def logged_in?                                                                #logged_inメソッド。htmlのログイン判定で使う
    !current_user.nil?                                                          #current_userに値があればtrue、無ければfalseを返す。
  end
  

end
