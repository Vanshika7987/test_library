class BookPolicy < ApplicationPolicy
  attr_reader :user, :book

  def initialize(user, book)
    @user = user
    @book = book
  end

  def create?
    user.librarian?
  end

  def index?
    true
  end

  def new?
    user.librarian?
  end

  def book_issue_request?
    user.student?
  end

  def book_return_request?
    user.student?
  end

  def show?
    true
  end

  def edit?
    user.librarian?
  end

  def update?
    user.librarian?
  end

  def destroy?
    user.librarian?
  end
end
