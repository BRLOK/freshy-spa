class ChangeAttendancesAndItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :attendance_items, :user_id, :integer
    add_column :attendances, :user_id, :integer, index: true
    add_column :attendances, :duration, :integer
  end
end
