class DaySchedule < ApplicationRecord
  belongs_to :user
  has_many :time_schedule, dependent: :destroy
  validates :user_id, presence: true
  validates :schedule ,presence: true,length: { maximum: 255 }
end