class StudentsController < ApplicationController
  def index; end

  def show
    @user = User.find(params[:id])
  end

  def profile; end

  def myhistory
    @history = History.where(issued_to_id: current_user.id)
    @book = Book.where(id: @history.pluck(:book_id))
  end
end
