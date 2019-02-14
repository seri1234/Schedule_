require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:user)
  end
  
  test "associated schedule_per_day should be destroyed" do
    @user.save
    @user.schedule_per_days.create!(schedule: "Lorem ipsum",day_of_the_week: 1)
    assert_difference 'SchedulePerDay.count', -1 do
      @user.destroy
    end
  end
end
