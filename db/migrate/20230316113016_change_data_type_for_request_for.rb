class ChangeDataTypeForRequestFor < ActiveRecord::Migration[7.0]
  def self.up
    change_table :book_requests do |t|
      t.change :request_for, :string
    end
  end

  def self.down
    change_table :book_requests do |t|
      t.change :request_for, :integer
    end
  end
end
