require 'spec_helper'

describe NeighborsController do
  describe '#show' do
    let!(:shelf) { create :shelf }
    let!(:shelf2) { create :shelf }
    let!(:shelf_book) { create :shelf_book, shelf: shelf }

    context 'when book has neighbors' do
      before do
        create :shelf_book, shelf: shelf
        create :shelf_book, shelf: shelf2, book_id: shelf_book.book_id
        create :shelf_book, shelf: shelf2
        get :show, book_id: shelf_book.book_id
      end

      it { should redirect_to controller: 'books',
                              action: 'search',
                              ids: [
                                shelf2.shelf_books.last.book_id,
                                shelf.shelf_books.last.book_id
                              ] }
    end

    context 'when books has no neighbors' do
      before do
        create :shelf_book, shelf: shelf2
        get :show, book_id: shelf_book.book_id
      end

      it { should respond_with 404 }
    end
  end
end