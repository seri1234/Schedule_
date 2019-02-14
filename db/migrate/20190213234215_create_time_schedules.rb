class CreateTimeSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :time_schedules do |t|
      t.string :time_schedule
      t.string :start_time
      t.string :end_time
      t.references :day_schedule, foreign_key: true

      t.timestamps
    end
  end
end
