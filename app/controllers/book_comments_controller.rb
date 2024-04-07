class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @user = @book.user
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment.save
    # redirect_to book_path(book)
  end

  def destroy
    # BookComment.find(params[:id]).destroy
    @book_comment = BookComment.find(params[:id]).destroy
    @book_comment.destroy
    @book = Book.find(params[:book_id])
    # redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
