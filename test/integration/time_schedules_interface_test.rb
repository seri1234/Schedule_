require 'test_helper'

class TimeSchedulesInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user)
  end
  

  test "スケジュール新規作成機能に関するテスト-通常のリクエスト" do                             #createアクションのif文条件分岐3つ網羅成
    # 準備としてday_scheduleを作成
    login(@user)                                                                         #test_helperのloginメソッド
    get new_schedule_path      
    assert_difference 'DaySchedule.count', 1 do 
      post schedule_index_path, params: { day_schedule: { day_schedule: "テスト用文章" } } 
    end
    follow_redirect! 
    assert_equal 'スケジュールの作成に成功しました！', flash[:success]
    assert_template 'time_schedules/new'
    # 無効なtime_schedule作成
    assert_no_difference 'TimeSchedule.count' do 
    post schedule_time_schedules_path(@user.day_schedule.first),params: {time_schedule: {time_schedule: "",
                                                                                        start_time: "" ,
                                                                                        end_time: ""}}
    end
    assert_equal '「時間辺りの予定名」欄が空か256文字以上です。「予定を追加する」で再度追加するか、スケジュールを削除して、もう一度作り直してください。', flash[:danger]
    assert_template 'users/show'
    # 有効なtime_schedule作成
    assert_difference 'TimeSchedule.count', 1 do 
    post schedule_time_schedules_path(@user.day_schedule.first),params: {time_schedule: {time_schedule: "テスト用文章",
                                                                                        start_time: "1900-00-01 02:00:00" ,
                                                                                        end_time: "1900-00-01 03:00:00"}}
    end
    #作成されたかの確認
    get new_schedule_time_schedule_path(@user.day_schedule.first)               #time_schedule追加ページ
    assert_match "テスト用文章" , response.body 
    assert_match "02:00 ～ 03:00" , response.body                              
    get schedule_path(@user.day_schedule.first)                                 #スケジュール確認ページ
    assert_match "テスト用文章" , response.body 
    assert_match "02:00 ～ 03:00" , response.body
  end

  
#  test "スケジュール新規作成機能に関するテスト-Ajax" do 
    # 準備としてday_scheduleを作成
#    login                                                                         #test_helperのloginメソッド
#    get new_schedule_path      
#    assert_difference 'DaySchedule.count', 1 do 
#      post schedule_index_path, params: { day_schedule: { day_schedule: "テスト用文章" } } 
#    end
#    follow_redirect! 
#    assert_equal 'スケジュールの作成に成功しました！', flash[:success]
#    assert_template 'time_schedules/new'
    # 無効なtime_schedule作成
#    assert_no_difference 'TimeSchedule.count' do 
#    post schedule_time_schedules_path(@user.day_schedule.first),params: {time_schedule: {time_schedule: "",
#                                                                                        start_time: "" ,
#                                                                                        end_time: ""}}
#    end
#    assert_equal '「時間辺りの予定名」欄が空か256文字以上です。「予定を追加する」で再度追加するか、スケジュールを削除して、もう一度作り直してください。', flash[:danger]
#    assert_template 'users/show'
    # 有効なtime_schedule作成
#    assert_difference 'TimeSchedule.count', 1 do 
#    post schedule_time_schedules_path(@user.day_schedule.first),xhr: true,params: {time_schedule: {time_schedule: "テスト用文章",
#                                                                                  start_time: "1900-00-01 01:00:00" ,
#                                                                                  end_time: "1900-00-01 02:00:00"}}
#    end
#    get new_schedule_time_schedule_path(@user.day_schedule.first)
#    assert_match "テスト用文章" , response.body 
#    assert_match "10:00" , response.body 
#    assert_match "11:00" , response.body 
#    #timeschedule
#  end
    
end
