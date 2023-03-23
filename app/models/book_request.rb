class BookRequest < ApplicationRecord
  acts_as_paranoid
  validates :book_id, uniqueness: { scope: [:students_id] }

  enum request_for: { issue: 'issue', return_b: 'return' }
end
