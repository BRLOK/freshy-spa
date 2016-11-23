class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :cpf
      t.string :telephone
      t.boolean :active, default: true, nil: false

      t.timestamps
    end
  end
end
