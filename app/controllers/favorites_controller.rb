class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # リダイレクト先を削除・create.js.erbを読み込み
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # リダイレクト先を削除・destroy.js.erbを読み込み
    # redirect_back(fallback_location: root_path)
  end

end
