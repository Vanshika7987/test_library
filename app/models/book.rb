class Book < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :library
  has_many :book_dues, dependent: :destroy
  has_many :book_requests, dependent: :destroy
  has_many :histories, dependent: :destroy

  has_one_attached :image
  validates :name, presence: { message: 'name cant be blank' }
  validates :author, presence: { message: 'author name cant be blank' }
  validates :language, presence: { message: 'language cant be blank' }

  def self.search(search)
    where('name LIKE ?', "%#{search}%")
  end

  scope :book_id, ->(_id) { where('id > ?', _id) }

  def available?
    issued_to.blank?
  end
end
