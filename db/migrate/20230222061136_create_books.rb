class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :language
      # t.references :library, index: true, foreign_key: true
      t.datetime :issued_from_at
      t.datetime :issued_to_at
      t.references :issued_to, index: true, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
