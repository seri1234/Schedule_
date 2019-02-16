require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:user)
  end
  
  test "サニティーチェック" do
    assert @user.valid?
  end
  
  test "user_nameのバリデーションが機能するか" do
    @user.user_name = "     "
    assert_not @user.valid?
  end
  
  test "uidのバリデーションが機能するか" do
    @user.uid = ""
    assert_not @user.valid?
  end
  
  test "providerのバリデーションが機能するか" do
    @user.provider = ""
    assert_not @user.valid?
  end
  
  
  test "Userモデルが削除されると紐付いているDayScheduleモデルも同時に削除されるか" do
    @user.save
    @user.day_schedule.create!(day_schedule: "test")
    assert_difference 'DaySchedule.count', -1 do
      @user.destroy
    end
  end
end
