class BookRequest < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :book
  belongs_to :library

  validates :book_id, uniqueness: { scope: [:student_id] }

  enum request_for: { issue: 'issue', return: 'return' }
end
