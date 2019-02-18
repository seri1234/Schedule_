require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:user)
    @other_user = users(:other_user)
  end

  test "未ログイン状態でユーザ一覧ページにgetアクセスするとログインページにリダイレクトされるか" do                            
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
    
  test "ログインユーザーと違うユーザーを削除するときちんと失敗するか" do                         #自分以外の投稿を削除しようとするときちんとリダイレクトされるかのテスト
    login(@user)                                                  #michaelとしてログイン)
    assert_no_difference 'User.count' do                                        #以下のことをしてもPostモデルのデータ数は変わらないか
      delete user_path(@other_user)                                                    #antsとしてpost_pathにdeleteアクセス。記事を削除
    end
    assert_redirected_to root_url                                               #きちんとリダイレクトされるか
  end
end
