class SearchesController < ApplicationController

  def search
    @range = params[:range]
    @search = params[:search]
    @word = params[:word]

    if @range == ''
      @records = User.search(@search,@word)
    else
      @records = Book.search(@search,@word)
    end
  end

end
