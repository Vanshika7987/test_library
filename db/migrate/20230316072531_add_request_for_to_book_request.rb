class AddRequestForToBookRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :book_requests, :request_for, :integer
  end
end
