class LibrariansController < ApplicationController
  def index; end

  def show; end

  def profile; end

  # @bks = Book.where(id: @bookissuerequest.pluck(:book_id))
  # def request(_request)
  # end

  def get_books_for_approval
    @library = Library.find_by(librarian_id: current_user.id)
    @requests = BookRequest.where(library_id: @library.id)
    # @requested_student_books = Book.where(id: @request.pluck(:book_id))
    # @requested_users = User.where(id: @request.pluck(:students_id))
  end

  def approve
    @book_request = BookRequest.find(params[:id])
    @book_request.status = true
    @book_request.save
    book = Book.find_by(id: @book_request.book_id)
    if @book_request.request_for === 'issue'
      history = History.new
      history.book_id = @book_request.book_id
      history.issued_to_id = @book_request.students_id
      history.issued_from_at = Date.current
      history.issued_to_at = Date.current + 7
      history.event = 'issued'
      history.save
      book.issued_from_at = Date.current
      book.issued_to_at = Date.current + 7
      book.issued_to_id = @book_request.students_id
      book.save
    else
      history = History.new
      history.book_id = @book_request.book_id
      history.issued_to_id = @book_request.students_id
      history.event = 'returned'
      history.save
      book.issued_from_at = nil
      book.issued_to_at = nil
      book.issued_to_id = nil
      book.save
    end
    # render json: { data: @book_request.id }
    @book_request.destroy
  end

  def ignore
    @book_request = BookRequest.find(params[:id])
    @book_request.destroy
  end
end
