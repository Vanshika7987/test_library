class CreateLibraries < ActiveRecord::Migration[7.0]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :address
      t.references :librarian, index: true, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
