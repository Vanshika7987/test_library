class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  paginates_per 5

  # has_many :student_specific_book_issue_requests, foreign_key: 'student_id'
  # has_many :my_requested_books, through: :student_specific_book_issue_requests

  has_many :book_dues
  has_many :books
  has_one :library, foreign_key: 'librarian_id'

  # validates :name, :role, :phone_number, presence: true

  enum role: { student: 0, librarian: 1 }
  after_save :create_library
  def create_library
    return unless librarian?

    library = Library.create(name: name, address: 'indore', librarian_id: id)
    library.save
  end

  def message
    puts 'we are creating your account'
  end

  def my_issued_books
    return nil if librarian?

    Book.where(issued_to_id: id)
  end


  def self.from_google(auth)
    # binding.pry
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # binding.pry
      user.email = auth.info.email,
      user.password = Devise.friendly_token[0, 20],
      user.name = auth.info.name
      user.save
    end
  end
end
