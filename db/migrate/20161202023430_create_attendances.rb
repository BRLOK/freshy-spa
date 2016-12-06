class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.belongs_to :customer, index: true
      t.datetime :scheduled_for
      t.string :status
    end
  end
end
