class ChangeBookIssueRequestToBookRequest < ActiveRecord::Migration[7.0]
  def change
    rename_table :book_issue_requests, :book_requests
  end
end
