require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:user)
  end

  test "未ログイン状態でユーザ一覧ページにgetアクセスするとログインページにリダイレクトれるか" do                            
    get users_path                                                              
    assert_redirected_to root_url
  end
  
  test "未ログイン状態でユーザーページにgetアクセするときちんとログインページにリダイレクトされるか。" do                            
    get user_path(@user)
    assert_redirected_to root_url 
  end
  
  test "未ログイン状態でユーザ情報を削除するときちんと失敗するか" do           
    assert_no_difference 'User.count' do                                        
      delete user_path(@user)                                                   
    end
    assert_redirected_to root_url                                               
  end
end
