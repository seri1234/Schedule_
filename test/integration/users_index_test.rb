require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user)
  end

  test "ページネーションがうまく機能しているか" do
    login(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1, per_page: 5).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.user_name
    end
  end
end
