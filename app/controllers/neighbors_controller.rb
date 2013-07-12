class NeighborsController < ApplicationController
  def show
    shelves = Shelf.joins(:shelf_items).where('shelf_items.item_id' => params[:book_id])
    item_ids = shelves.collect do |shelf|
      shelf.item_ids
    end.flatten.uniq
    item_ids.delete params[:book_id]

    if item_ids.empty?
      head 204
    else
      redirect_to controller: 'books',
                  action: 'search',
                  search_type: 'ids',
                  query: item_ids.join(',')
    end
  end
end