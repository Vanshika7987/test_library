class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy book_detail checkout return_book]
  def index
    # @books = if params[:search]
    #            Book.search(params[:search]).order('created_at desc')
    #          else
    #            Book.all.order('created_at desc')
    #          end
    @q = Book.ransack(params[:q])
    @books = @q.result
  end

  def book_list
    @q = Book.ransack(params[:q])
    @books = @q.result
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.library_id = current_user.library.id
    if @book.save
      redirect_to books_path, notice: 'book created'
    else
      redirect_to new_book_path
    end
  end

  def checkout
    @book_issue_request = BookRequest.new
    @book_issue_request.book_id = @book.id
    @book_issue_request.students_id = current_user.id
    @book_issue_request.library_id = @book.library_id
    @book_issue_request.request_from = Date.current
    @book_issue_request.request_to = Date.current + 7
    @book_issue_request.request_for = 'issue'
    if @book_issue_request.save
      @bookissuerequest = BookRequest.where(students_id: current_user.id)
      @bks = Book.where(id: @bookissuerequest.pluck(:book_id))
    else
      render 'book_detail'
    end
  end

  def return_book
    @book_return_request = BookRequest.new
    @book_return_request.book_id = @book.id
    @book_return_request.students_id = current_user.id
    @book_return_request.library_id = @book.library_id
    @book_return_request.request_for = 'return'
    @book_return_request.save
    # history = History.new
    # history.book_id = @book_id
    # history.issued_to_id = current_user.id
    # history.event = 'returned'
    # history.save
  end

  def book_detail
    # @book_issue_request = BookRequest.new
    @book_issue_request = BookRequest.find_by(book_id: @book.id, students_id: current_user.id)
    # @book_issue_request.students_id = current_user.id
  end

  def show; end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to books_path(@book), notice: 'book updated'
    else
      render edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: 'book deleted'
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :language)
  end

  def history_params
    params.require(:history).permit(:book_id, :issued_to_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
