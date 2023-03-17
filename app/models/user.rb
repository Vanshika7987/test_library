class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  paginates_per 5

  has_many :student_specific_book_issue_requests, foreign_key: 'student_id'
  has_many :my_requested_books, through: :student_specific_book_issue_requests

  has_one :library, foreign_key: 'librarian_id'

  validates :name, :role, :phone_number, presence: true

  enum role: { student: 0, librarian: 1 }

  before_create :message
  def message
    puts 'we are creating your account'
  end

  def my_issued_books
    return nil if librarian?

    Book.where(issued_to_id: id)
  end
end
