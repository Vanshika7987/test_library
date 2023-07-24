class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy book_issue_request book_return_request]
  skip_after_action :verify_authorized, only: [:upload, :export_file]
  def index
    authorize :book
    @books = if params[:search]
               Book.search(params[:search]).order('created_at desc')
             else
               Book.all.order('created_at desc')
             end
    email_otp = EmailOtp.create(email: current_user.email)
    UserMailer.send_otp(current_user, email_otp.pin).deliver_now
    
  end

  def new
    authorize :book
    @book = Book.new
  end

  def create
    # UserMailer.welcome(current_user).deliver_now
    @book = Book.new(book_params)
    @book.image.attach(params[:book][:image]) if params[:book][:image].present?
    library = Library.find_by(librarian_id: current_user.id)
    authorize(@book)

    @book.library_id = library.id
    if @book.save
      redirect_to books_path, notice: 'book created successfully.'
    else
      render :new, status: 500
    end
  end

  def book_issue_request
    authorize @book
    create_request
    @book_request.issue_from_date = Date.current
    @book_request.issue_till_date = Date.current + 7
    @book_request.request_for = 'issue'
    if @book_request.save
      @bookissuerequest = BookRequest.where(student_id: current_user.id)
      @bks = Book.where(id: @bookissuerequest.pluck(:book_id)) 
      library = Library.find_by(id: @book_request.library_id)
      user = User.find_by(id: library.librarian_id)
      @request = BookRequest.includes(:book, :student).find_by(id: @book_request.id)
      UserMailer.request_mail(user, @request).deliver_now
    else
      render 'show'
    end
  end

  def book_return_request
    authorize @book
    create_request
    @book_request.request_for = 'return'
    @book_request.save

    apply_fine if is_book_overdue?
  end

  def show
    authorize @book
    return unless current_user.student?

    @book_issue_request = BookRequest.find_by(book_id: @book.id, student_id: current_user.id)
  end

  def edit
    authorize @book
  end

  def update
    authorize @book
    if @book.update(book_params)
      redirect_to books_path(@book), notice: 'book updated successfully'
    else
      render :edit
    end
  end

  def destroy
    authorize @book
    @book.destroy
    redirect_to books_path, notice: 'book deleted successfully'
  end

  def upload
    excel_file = params[:excel_file]

    if excel_file.present?
      spreadsheet = Roo::Spreadsheet.open(excel_file.tempfile)
       (2..spreadsheet.last_row).each do |row|
        data = spreadsheet.row(row)
        name =         data[0]
        author =       data[1]
        language =     data[2]
        library =      data[3]
        Book.create(name: name, author: author, language: language, library_id: library)

        flash[:success] = 'Data imported successfully'

      end
        flash[:error] = 'please select valid file'
    else
        redirect_to action: 'index'
    end
  end

  def export_file
    @books = Book.all
    
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(name: "all_books") do |sheet|
        sheet.add_row ["Name", "Author", "Language", "Library"]
        @books.each do |book|
          sheet.add_row [book.name,book.author,book.language,book.library_id]
        end
      end

      # response.headers['Content-Type'] = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      # response.headers['Content-Disposition'] = 'attachment; filename="all_books.xlsx"'
      send_data p.to_stream.read, filename: 'all_books.xlsx'

    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :language, :image)
  end

  def history_params
    params.require(:history).permit(:book_id, :issued_to_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def apply_fine
    bookdue = @book.book_dues.new(student_id: current_user.id, fine: calculate_fine)
    bookdue.save
  end

  def create_request
    @book_request = BookRequest.new(book_id: @book.id, student_id: current_user.id, library_id: @book.library_id)
    @book_request.save
  end

  def calculate_fine
    (Date.current.to_date - @book.issued_to_at.to_date).to_i * 5
  end

  def is_book_overdue?
    @book.issued_to_at < Date.current
  end
end
