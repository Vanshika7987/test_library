class LibrariansController < ApplicationController
  before_action :set_book_request, only: %i[approve ignore]
  after_action :verify_authorized, except: %i[approve ignore]

  def index
    authorize :user
  end

  def show
    authorize :user
  end

  def profile
    authorize :user
  end

  def get_books_for_approval
    authorize :user
    library = Library.find_by(librarian_id: current_user.id)
    @requests = BookRequest.includes(:book, :student).where(library_id: library.id)
  end

  def approve
    @book_request.status = true
    @book_request.save
    book = Book.find_by(id: @book_request.book_id)
    create_history
    if @book_request.request_for === 'issue'
      @history.issued_from_at = Date.current
      @history.issued_to_at = Date.current + 7
      @history.event = 'issued'
      @history.save
      book.issued_from_at = Date.current
      book.issued_to_at = Date.current + 7
      book.issued_to_id = @book_request.student_id
    else
      @history.event = 'returned'
      @history.save
      book.issued_from_at = nil
      book.issued_to_at = nil
      book.issued_to_id = nil
    end
    book.save
    @book_request.destroy
  end

  def ignore
    @book_request.destroy
  end

  def message_broadcast
    ActionCable.server.broadcast('chat_channel', params[:message])
  end

  def message_job
    MessageJob.perform_later(params[:message])
  end



  private

  def create_history
    @history = History.new(book_id: @book_request.book.id, issued_to_id: @book_request.student_id)
    @history.save
  end

  def set_book_request
    @book_request = BookRequest.find(params[:id])
  end
end
