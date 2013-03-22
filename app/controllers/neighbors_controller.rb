class NeighborsController < ApplicationController
  def show
    shelves = Shelf.joins(:shelf_books).where('shelf_books.book_id' => params[:book_id])
    book_ids = shelves.collect do |shelf|
      shelf.book_ids
    end.flatten.uniq
    book_ids.delete params[:book_id]

    if book_ids.empty?
      head 404
    else
      redirect_to controller: 'books', action: 'search', ids: book_ids
    end
  end
end