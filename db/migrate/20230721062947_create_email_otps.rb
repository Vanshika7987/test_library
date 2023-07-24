class CreateEmailOtps < ActiveRecord::Migration[7.0]
  def change
    create_table :email_otps do |t|
      t.string :email
      t.integer :pin 
      t.timestamps
    end
  end
end
