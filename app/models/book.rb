class Book < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :library

  # def self.search(search)
  #   where('name LIKE ?', "%#{search}%")
  # end
  def self.ransackable_attributes(_auth_object = nil)
    %w[author created_at id issued_from_at issued_to_at issued_to_id language library_id name
       updated_at]
  end

  def available?
    issued_to.blank?
  end
end
