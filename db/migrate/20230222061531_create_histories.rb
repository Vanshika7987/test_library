class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.references: book index: true, foreign_key: true
      
      t.references: issued_to index: true, foreign_key: {to_table: :users}
      t.datetime: issued_from_at
      t.datetime: issued_to_at
      t.timestamps
    end
  end
end
