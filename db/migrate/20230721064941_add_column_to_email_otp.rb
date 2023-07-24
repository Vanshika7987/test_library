class AddColumnToEmailOtp < ActiveRecord::Migration[7.0]
  def change
    add_column :email_otps, :valid_until, :datetime
    add_column :email_otps, :active, :boolean
  end
end
