require 'spec_helper'

describe NeighborsController do
  describe '#show' do
    let!(:shelf) { create :shelf }
    let!(:shelf2) { create :shelf }
    let!(:shelf_item) { create :shelf_item, shelf: shelf }

    context 'when book has neighbors' do
      before do
        create :shelf_item, shelf: shelf
        create :shelf_item, shelf: shelf2, item_id: shelf_item.item_id
        create :shelf_item, shelf: shelf2
        get :show, book_id: shelf_item.item_id
      end

      it { should redirect_to controller: 'books',
                              action: 'search',
                              search_type: 'ids',
                              query: [
                                shelf2.shelf_items.last.item_id,
                                shelf.shelf_items.last.item_id
                              ].join(',') }
    end

    context 'when book has no neighbors' do
      before do
        create :shelf_item, shelf: shelf2
        get :show, book_id: shelf_item.item_id
      end

      it { should respond_with 204 }
    end
  end
end