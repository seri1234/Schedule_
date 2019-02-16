require 'test_helper'

class TimeScheduleTest < ActiveSupport::TestCase

  def setup                                              
    @time_schedule =TimeSchedule.new( day_schedule_id: day_schedules(:one_day).id,
                                        time_schedule: "test_plan",start_time: "1900-00-00 01:00:00" ,end_time: "1900-00-00 02:00:00" )
  end
  
  test "サニティーチェック" do
    assert  @time_schedule.valid?
  end
  
  test "dayschedule_idのバリデーションが機能するか" do
    @time_schedule.day_schedule_id = ""
    assert_not  @time_schedule.valid?
  end
  
  test "start_timeのpresenceバリデーションが機能するか" do
    @time_schedule.start_time = ""
    assert_not @time_schedule.valid?
  end

  test "end_timeのpresenceバリデーションが機能するか" do
    @time_schedule.end_time =""
    assert_not @time_schedule.valid?
  end  
end