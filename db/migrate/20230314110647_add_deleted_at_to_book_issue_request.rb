class AddDeletedAtToBookRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :book_requests, :deleted_at, :datetime
    add_index :book_requests, :deleted_at
  end
end
