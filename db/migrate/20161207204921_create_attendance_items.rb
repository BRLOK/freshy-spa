class CreateAttendanceItems < ActiveRecord::Migration[5.0]
  def change
    create_table :attendance_items do |t|
      t.belongs_to :attendance, index: true
      t.belongs_to :service, index: true
      t.belongs_to :user, index: true
      t.datetime :started_at
      t.datetime :finished_at
    end
  end
end
