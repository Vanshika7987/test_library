class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def profile?
    true
  end

  def my_history?
    user.student?
  end

  def get_books_for_approval?
    user.librarian?
  end
end
