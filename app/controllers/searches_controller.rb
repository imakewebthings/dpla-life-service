class SearchesController < ApplicationController
  def show
    if params[:query]
      search_by_query
    elsif params[:ids]
      search_by_ids
    end
  end

  private
    def search_by_query
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

    def search_by_ids
      @limit = 0
      @start = -1
      unsorted_books = Book.where(:_id => params[:ids])
      @books = params[:ids].collect do |id|
        unsorted_books.detect {|x| x[:_id] == id}
      end
      @num_found = @books.length
    end

    def check_last_page
      if @books.empty? or @books.length < @limit
        @start = -1
      end
    end
end