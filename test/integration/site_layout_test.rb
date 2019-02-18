require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user)
  end

 test "ヘッダーとレイアウトに関するテスト" do
   login(@user) 
   get root_path
   assert_template 'home/index'
   assert_select "a[href=?]", user_path(session[:user_id])
   assert_select "a[href=?]", new_schedule_path
   assert_select "a[href=?]", users_path
   assert_select "a[href=?]", logout_path
  end
end
