class BooksController < ApplicationController
  before_filter :set_book_loader

  def show
    @book = @book_loader.single_book
  end

  def search
    @results = @book_loader.public_send "search_by_#{params[:search_type]}"
  end

  def recent_most_read
    popular_ids = BookReading.recent_most_read.keys
    redirect_to search_path(search_type: 'ids', query: popular_ids.join(','))
  end

  def set_book_loader
    case Rails.configuration.book_source
    when 'librarycloud'
      require 'books/librarycloud'
      @book_loader = Librarycloud.new(params)
    else
      require 'books/mocklib'
      @book_loader = Mocklib.new(params)
    end
  end
end