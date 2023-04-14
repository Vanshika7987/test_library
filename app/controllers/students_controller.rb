class StudentsController < ApplicationController
  def index
    authorize :user
  end

  def show
    authorize :user
    @user = User.find(params[:id])
  end

  def profile
    authorize :user
  end

  def my_history # name convention
    authorize :user
    history = History.mine(current_user.id)
    # @book = Book.find(id: history.book_id)
    # history = History.where(issued_to_id: current_user.id) # use scope
    @book = Book.where(id: history.pluck(:book_id))
    # Book.joins(:histories)
  end
end
