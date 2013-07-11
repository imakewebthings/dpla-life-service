require 'spec_helper'

describe NeighborsController do
  describe '#show' do
    let!(:shelf) { create :shelf }
    let!(:shelf2) { create :shelf }
    let!(:shelf_book) { create :shelf_book, shelf: shelf }

    context 'when book has neighbors' do
      before do
        create :shelf_book, shelf: shelf
        create :shelf_book, shelf: shelf2, item_id: shelf_book.item_id
        create :shelf_book, shelf: shelf2
        get :show, book_id: shelf_book.item_id
      end

      it { should redirect_to controller: 'books',
                              action: 'search',
                              search_type: 'ids',
                              query: [
                                shelf2.shelf_books.last.item_id,
                                shelf.shelf_books.last.item_id
                              ].join(',') }
    end

    context 'when books has no neighbors' do
      before do
        create :shelf_book, shelf: shelf2
        get :show, book_id: shelf_book.item_id
      end

      it { should respond_with 204 }
    end
  end
end