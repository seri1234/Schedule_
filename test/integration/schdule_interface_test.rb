require 'test_helper'

class SchduleInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user)
  end

  test "スケジュール新規作成機能に関するテスト）" do                             #createアクションのif文条件分岐3つ網羅
    login(@user)                                                                        #test_helperのloginメソッド
    get new_schedule_path                                                        
    assert_select 'h1', "スケジュール入力ページ" 
    assert_select 'input[type="text"]'
    # 無効な送信 条件分岐1
    assert_no_difference 'DaySchedule.count' do 
      post schedule_index_path, params: { day_schedule: { day_schedule: "" } } 
    end
    assert_equal '入力値が空か、255文字以上です。保存に失敗しました', flash[:danger]
    assert_template 'schedule/new'
    # 有効な送信
    assert_difference 'DaySchedule.count', 1 do 
      post schedule_index_path, params: { day_schedule: { day_schedule: "テスト用文章" } } 
    end
    follow_redirect! 
    assert_equal 'スケジュールの作成に成功しました！', flash[:success]
    assert_template 'time_schedules/new'
    # もう一度スケジュール新規作成
    get new_schedule_path                                                         
    assert_no_difference 'DaySchedule.count' do 
      post schedule_index_path, params: { day_schedule: { day_schedule: "テスト用文章2" } }
    end
    # 無効な送信
    assert_equal 'すでにあなたの予定は存在します、ヘッダーリンクの「予定とユーザー情報」ページから、一度予定を削除してからリトライしてください', flash[:danger]
    assert_template 'schedule/new'
    # スケジュール削除
    get user_path(@user)
    assert_difference 'DaySchedule.count', -1 do 
      delete schedule_path(@user.day_schedule.first)
    end
    follow_redirect! 
    assert_equal 'スケジュールを削除しました', flash[:success]
    assert_template 'home/index'
    end
end