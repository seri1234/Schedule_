require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:user)
  end
  
  test "ログインに関するテスト" do
    get root_url
    assert_select 'h1',"スケジュール管理サービスにようこそ！"
    assert_select 'a[href=?]',"/auth/twitter", text: "Twitterログイン"
    login(@user)
    follow_redirect! 
    assert_equal 'ユーザー認証が完了しました。', flash[:success]
    assert_match "Twitterログアウト", response.body,count:2
  end
end