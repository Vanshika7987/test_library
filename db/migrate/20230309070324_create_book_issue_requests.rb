class CreateBookRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :book_issue_requests do |t|
      t.references :book, index: true, foreign_key: true
      t.references :library, index: true, foreign_key: true
      t.references :students, index: true, foreign_key: { to_table: :users }
      t.datetime :request_to
      t.datetime :request_from
      t.boolean :status
      t.timestamps
    end
  end
end
