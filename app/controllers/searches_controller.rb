class SearchesController < ApplicationController
  def show
    offset = (params[:start] || 0).to_i
    @limit = (params[:limit] || 10).to_i
    @start =  offset + @limit

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

  private
    def check_last_page
      if @books.empty? or @books.length < @limit
        @start = -1
      end
    end
end