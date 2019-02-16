require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:user)
  end
  
  test "Userモデルが削除されると紐付いているDayScheduleモデルも同時に削除されるか" do
    @user.save
    @user.day_schedule.create!(day_schedule: "test")
    assert_difference 'DaySchedule.count', -1 do
      @user.destroy
    end
  end
end
