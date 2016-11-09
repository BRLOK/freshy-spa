class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :email
      t.string :role
      t.boolean :active, default: true, nil: false

      t.timestamps
    end
  end
end
