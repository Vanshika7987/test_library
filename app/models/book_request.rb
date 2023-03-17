class BookRequest < ApplicationRecord
  acts_as_paranoid
  validates :book_id, uniqueness: { scope: [:students_id] }

  # enum request_for: { issue: 0, return_b: 1 }
end
