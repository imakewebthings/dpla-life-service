class BooksController < ApplicationController
  def show
    @book = Book.find_by__id! params[:id]
  end
end