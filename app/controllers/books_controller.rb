class BooksController < ApplicationController
  before_filter :extend_for_book_source

  def show
    @book = Book.find_by_source_id! params[:id]
  end

  def search
    if params[:search_type] == 'keyword'
      search_by_keyword
    elsif params[:search_type] == 'subject'
      search_by_subject
    elsif params[:search_type] == 'subject_union'
      search_by_subject_union
    elsif params[:search_type] == 'subject_intersection'
      search_by_subject_intersection
    elsif params[:ids]
      search_by_ids
    end
  end

  def extend_for_book_source
    case Rails.configuration.book_source
    when 'hathi'
      require 'books/hathi'
      self.extend Hathi
    when 'openlibrary'
      self.extend OpenLibraryBooks
    end
  end

  def search_by_keyword
    offset = (params[:start] || 0).to_i
    @limit = (params[:limit] || 10).to_i
    @start = offset + @limit

    if params[:query] == 'empty'
      @books = []
      @num_found = 0
    else
      if (params[:start] == '-1')
        @books = Book.all
      else
        @books = Book.offset(offset).limit(@limit)
      end
      @num_found = Book.all.length
    end
    
    check_last_page
  end

  def search_by_subject
    @limit = (params[:limit] || 10).to_i
    @start = -1
    @books = Book.where('subjects LIKE ?', "%#{params[:query]}%").all
    @num_found = @books.length
  end

  def search_by_subject_union
    @limit = (params[:limit] || 10).to_i
    @start = -1
    book = Book.find_by_source_id params[:query]
    @books = book.subjects.collect do |subject|
      Book.where('subjects LIKE ?', "%#{subject}%").all
    end.flatten.uniq
    @books.delete book
    @num_found = @books.length
  end

  def search_by_subject_intersection
    @limit = (params[:limit] || 10).to_i
    @start = -1
    book = Book.find_by_source_id params[:query]
    if book.subjects.blank?
      @books = []
    else
      @books = Book
      book.subjects.each do |subject|
        @books = @books.where('subjects LIKE ?', "%#{subject}%")
      end
      @books = @books.all
      @books.delete book
    end
    @num_found = @books.length
  end

  def search_by_ids
    @limit = 0
    @start = -1
    unsorted_books = Book.where(:source_id => params[:ids])
    @books = params[:ids].collect do |id|
      unsorted_books.detect {|x| x[:source_id] == id}
    end
    @num_found = @books.length
  end

  def check_last_page
    if @books.empty? or @books.length < @limit
      @start = -1
    end
  end
end