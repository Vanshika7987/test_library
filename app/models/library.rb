class Library < ApplicationRecord
  has_many :library_specific_book_issue_requests, foreign_key: 'library_id'
  has_many :requested_books, through: :library_specific_book_issue_requests
  belongs_to :librarian, class_name: :User
  has_many :books
end
