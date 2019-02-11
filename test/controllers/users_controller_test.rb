require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:user)
    @other_user = users(:otheruser)
  end


#  test "should redirect index when not logged in" do                            
#    get users_path                                                              #未ログイン状態で/usersユーザー一覧ページにgetアクセス。
#    assert_redirected_to root_url                                              #きちんとログインページにリダイレクトされるか
#  end
  
#  test "should redirect show when not logged in" do                            
#    get user_path(@user)                                                         #未ログイン状態でユーザーページにgetアクセス。
#    assert_redirected_to root_url                                              #きちんとログインページにリダイレクトされるか
#  end
  
#  test "should redirect destroy when not logged in" do                          #未ログイン状態でユーザ情報を削除するときちんと失敗するか
#    assert_no_difference 'User.count' do                                        #下のことをしてもUserモデルのデータ数は変わらないか
#      delete user_path(@user)                                                   #@userでdeleteアクションアクセス
#    end
#    assert_redirected_to root_url                                               #きちんとリダイレクトされるか
# end

end
