class SearchesController < ApplicationController

  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]

    if @range == ''
      @user = User.search(search,word)
    else
      @book = Book.search(search,word)
    end
  end

end
