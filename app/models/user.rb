class User < ApplicationRecord
    paginates_per 5
    has_many :books
    validates :name, :role, :phone_number, presence: true
    enum role: {student: 0, librarian: 1}
end
