class CreateDues < ActiveRecord::Migration[7.0]
  def change
    create_table :dues do |t|
      t.references :book, index: true, foreign_key: true
      t.references :student_id, index: true, foreign_key: { to_table: :users }
      t.integer :fine
      t.timestamps
    end
  end
end
