class CreateDaySchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :day_schedules do |t|
      t.string :day_schedule
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
