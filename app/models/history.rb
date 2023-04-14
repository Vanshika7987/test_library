class History < ApplicationRecord
  scope :mine, ->(id) { where('issued_to_id >?', id) }
  #   scope :book_id, ->(_id) { where('id > ?', _id) }
  belongs_to :book
end
