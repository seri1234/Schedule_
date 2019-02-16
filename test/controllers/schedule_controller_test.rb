require 'test_helper'

class ScheduleControllerTest < ActionDispatch::IntegrationTest

  def setup
    @day_schedule =day_schedules(:one_day)
  end

  test "未ログイン状態でスケジュールページにgetアクセスすると、ルートページにリダイレクトされるか" do
    get schedule_path(@day_schedule)
    assert_redirected_to root_url
  end

  test "未ログイン状態で予定新規作成ページにgetアクセスすると、ルートページにリダイレクトされるか" do
    get new_schedule_path
    assert_redirected_to root_url
  end

  test "未ログイン状態でschedule_index_pathにpostアクセスするとDBに保存されずにルートページにリダイレクトされるか" do
    assert_no_difference 'DaySchedule.count' do
      post schedule_index_path, params: { post: { day_schedule: "Lorem ipsum" } } 
    end
    assert_redirected_to root_url
  end
  
  test "未ログイン状態でschedule_pathにdeleteアクセスすると、ルートページにリダイレクトされるか" do
    assert_no_difference 'DaySchedule.count' do
      delete schedule_path(@day_schedule)
    end
    assert_redirected_to root_url                     
  end
end