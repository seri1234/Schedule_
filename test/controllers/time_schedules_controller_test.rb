require 'test_helper'

class TimeSchedulesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @time_schedule = time_schedules(:first_time)
  end


  test "未ログイン状態でtime_schedule_pathにgetアクセスすると、ルートページにリダイレクトされるか" do
    get new_schedule_time_schedule_path(@time_schedule)                         #newアクション  /schedule/:schedule_id/time_schedules/new
    assert_redirected_to root_url
  end
  
  test "未ログイン状態でtime_schedule_pathにpostアクセスするとにpostアクセスするとDBに保存されずにルートページにリダイレクトされる" do
      assert_no_difference 'TimeSchedule.count' do                               #createアクション  /schedule/:schedule_id/time_schedules
      post schedule_time_schedules_path(@time_schedule), params: { post: {day_schedule_id: 1,
                                                                            time_schedule: "test",
                                                                            start_time:  "1900-00-01 01:00:00",
                                                                            end_time:  "1900-00-01 02:00:00"} }
    end
    assert_redirected_to root_url
  end
  
end
