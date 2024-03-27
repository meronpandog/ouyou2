class BooksController < ApplicationController
 before_action :require_login, only: [:edit]

  def show
    # @books = Book.find(params)
    @books = Book.new
    @book = Book.find(params[:id])
    @user = User.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @books = Book.all
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)#, :image, :name
  end

  def require_login
   unless current_user
    redirect_to login_url, alert: "ログインしてください"
   end
  end
end
