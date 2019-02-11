class UsersProfileTest < ActionDispatch::IntegrationTest
    include ApplicationHelper

  def setup
    @user = users(:user)
  end

  test "profile display" do                                                     #ユーザーロフィールページのテスト
    get user_path(@user)                                                        #user/idにgetアクセス
    assert_template 'users/show'                                                #show.html.erbがきちんと表示されているか
    assert_select 'h1', text: @user.user_name                                   #h1タグにユーザーの名前があるか
  end
  
  
end
  