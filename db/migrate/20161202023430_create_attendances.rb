class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.belongs_to :customer, index: true
      t.date :scheduled_for
      t.string :status

      t.timestamps
    end
  end
end
