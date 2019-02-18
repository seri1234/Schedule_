require 'test_helper'

class TimeSchedulesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @time_schedule = time_schedules(:first_time)
    @user = users(:user)
    @other_user = users(:other_user)
  end


  test "未ログイン状態でtime_schedule_pathにgetアクセスすると、ルートページにリダイレクトされるか" do
    get new_schedule_time_schedule_path(@time_schedule)                         #newアクション  /schedule/:schedule_id/time_schedules/new
    assert_redirected_to root_url
  end
  
  test "未ログイン状態でtime_schedule_pathにpostアクセスするとにpostアクセスするとDBに保存されずにルートページにリダイレクトされるか" do
      assert_no_difference 'TimeSchedule.count' do                               #createアクション  /schedule/:schedule_id/time_schedules
      post schedule_time_schedules_path(@time_schedule), params: { time_schedule: {day_schedule_id: 1,
                                                                  time_schedule: "test",
                                                                  start_time:  "1900-00-01 01:00:00",
                                                                  end_time:  "1900-00-01 02:00:00"} }
    end
    assert_redirected_to root_url
  end
  
  test "ログインユーザー以外のTimeScheduleの新規投稿ページにアクセスするときちんと失敗するか" do
    login(@user)
    get new_schedule_time_schedule_path(@other_user)                                
    assert_redirected_to root_url                                               
  end
 
  
  test "ログインユーザー以外のTimeScheduleにpostアクセスするときちんと失敗するか" do
    login(@user) 
    post schedule_time_schedules_path(@time_schedule), params: { time_schedule: {day_schedule_id: 1,
                                                                time_schedule: "test",
                                                                start_time:  "1900-00-01 01:00:00",
                                                                end_time:  "1900-00-01 02:00:00"} }                                
    assert_redirected_to root_url                                               
  end
end