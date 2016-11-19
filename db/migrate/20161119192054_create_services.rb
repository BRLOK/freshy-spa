class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.integer :duration
      t.boolean :active, default: true, nil: false

      t.timestamps
    end
  end
end
