class ChangeColumnsInBookRequests < ActiveRecord::Migration[7.0]
  def change
    remove_column :book_requests, :students_id
    remove_column :book_requests, :request_to
    remove_column :book_requests, :request_from


    add_column :book_requests, :student_id, :integer
    add_column :book_requests, :issue_from_date, :datetime
    add_column :book_requests, :issue_till_date, :datetime
  end
end
