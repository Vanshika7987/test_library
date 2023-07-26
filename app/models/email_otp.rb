class EmailOtp < ApplicationRecord
  # self.abstract_class = true
  # self.table_name = :email_otps

  validate :valid_email
  validates :email, presence: true
  
  before_create :generate_otp

  def generate_otp
    self.pin = rand(1000..9999)
    self.valid_until = Time.now + 5.minutes
  end

  private 
  def valid_email
    unless URI::MailTo::EMAIL_REGEXP.match?(email)
      errors.add("email is not valid")
    end
  end
end
