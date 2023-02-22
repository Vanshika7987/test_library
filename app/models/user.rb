class User < ApplicationRecord
    validates :name, :role, :phone_number, presence: true
end
