require 'test_helper'

class TimeSchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get time_schedules_new_url
    assert_response :success
  end

end
