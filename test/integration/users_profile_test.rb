require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:user)
    @other_user = users(:other_user)
  end

  test "ユーザープロフィールページのテスト" do
    login(@user)
    get user_path(@user)
    # スケジュール未作成の場合
    assert_template 'users/show'                                                
    assert_match "アカウント削除", response.body                                #ユーザー削除ボタンがあるか
    assert_no_match "予定を見る", response.body                                 #予定を見るボタンが無いか
    assert_no_match "予定を追加する", response.body                             #予定を追加するボタンが無いか
    assert_no_match "予定削除", response.body                                   #予定削除ボタンが無いか
    # スケジュールを作成した場合
    get new_schedule_path      
    assert_difference 'DaySchedule.count', 1 do 
      post schedule_index_path, params: { day_schedule: { day_schedule: "テスト用文章" } } 
    end
    get user_path(@user)
    assert_match "アカウント削除", response.body                                #ユーザー削除ボタンがあるか
    assert_match "予定を見る", response.body                                    #予定を見るボタンがあるか
    assert_match "予定を追加する", response.body                                #予定を追加するボタンがあるか
    assert_match "予定削除", response.body                                      #予定削除ボタンが無いか
    #ユーザーを削除する。
    delete user_path(@user)
    follow_redirect!
    assert_template 'home/index'  
    login(@other_user)                                                          #他のユーザーでログイン
    get users_path                                                              #ユーザー一覧から消えているか
    assert_select 'a', text: @user.user_name, count: 0                      
  end


  test "他のユーザーでアクセスした場合、予定を追加するボタンと予定削除ボタンが表示されないか" do
    login(@user)
    get new_schedule_path  
    post schedule_index_path, params: { day_schedule: { day_schedule: "テスト用文章" } } 
    logout
    login(@other_user)
    get user_path(@user)
    assert_no_match "アカウント削除", response.body
    assert_no_match "予定を追加する", response.body                             #予定を追加するボタンが無いか
    assert_no_match "予定削除", response.body                                   #予定削除ボタンが無いか
  end
end
  