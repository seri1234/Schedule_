require 'test_helper'

class DayScheduleTest < ActiveSupport::TestCase

  def setup
    @user = users(:user)
    @day_schedule = @user.day_schedule.build(day_schedule: "test_plan")
  end
  
  test "サニティーチェック" do
    assert @day_schedule.valid?
  end
  
  test "user_idのバリデーションが機能するか" do
    @day_schedule.user_id = ""
    assert_not @day_schedule.valid?
  end
  
  test "day_scheduleのpresenceバリデーションが機能するか" do
    @day_schedule.day_schedule = "     "
    assert_not @day_schedule.valid?
  end

  test "day_scheduleのlengthバリデーションが機能するか" do
    @day_schedule.day_schedule = "a" * 256
    assert_not @day_schedule.valid?
  end  
  

  test "Dayscheduleモデルが削除されると紐付いているTimeScheduleモデルも同時に削除されるか" do
    @day_schedule.save
    @day_schedule.time_schedule.create!(time_schedule: "test" ,start_time:"1900-00-00 01:00:00",end_time:"1900-00-00 02:00:00")
    assert_difference 'TimeSchedule.count', -1 do
      @day_schedule.destroy
    end
  end
end