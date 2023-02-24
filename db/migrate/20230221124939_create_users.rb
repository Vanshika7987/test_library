class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :role, default: 0
      t.string :phone_number
      t.timestamps
    end
  end
end
