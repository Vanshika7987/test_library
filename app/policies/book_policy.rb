class BookPolicy < ApplicationPolicy
  attr_reader :user, :book

  def initialize(user,book)
    @user = user
    @book = book
  end

  def create?
    user.librarian?
  end
end
