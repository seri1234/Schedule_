class TimeSchedule < ApplicationRecord
  belongs_to :day_schedule
  validates :day_schedule_id, presence: true
  validates :time_schedule, presence: true,length: { maximum: 255 }
  validates :start_time ,presence: true
  validates :end_time ,presence: true
  
end
