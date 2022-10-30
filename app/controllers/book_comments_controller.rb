class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_params)
    @comment.book_id = @book.id
    @comment.save
    # redirect_back(fallback_location: root_path)
    render :book_comments
  end

  def destroy
    BookComment.find(params[:id]).destroy
    @book = Book.find(params[:book_id])
    # redirect_to book_path(params[:book_id])
    render :book_comments
  end

  private

  def book_params
    params.require(:book_comment).permit(:comment)
  end

end
