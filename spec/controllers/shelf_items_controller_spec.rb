require 'spec_helper'

describe ShelfItemsController do
  let(:user) { create :user }
  let(:shelf) { create :shelf }
  let(:shelf_item) { create :shelf_item }

  describe '#create' do
    context 'when not logged in' do
      before do
        post :create, shelf_id: shelf.id, item: attributes_for(:shelf_item)
      end

      it { should respond_with 401 }
      it { should render_template nil }
      specify { shelf.reload.item_ids.should be_blank }
      specify { shelf.reload.shelf_items.should be_blank }
    end

    context 'when shelf does not belong to user' do
      before do
        set_token user.token
        post :create, shelf_id: shelf.id, item: attributes_for(:shelf_item)
      end

      it { should respond_with 401 }
      it { should render_template nil }
      specify { shelf.reload.item_ids.should be_blank }
      specify { shelf.reload.shelf_items.should be_blank }
    end

    context 'when shelf belongs to user' do
      before do
        set_token shelf.user.token
        post :create, shelf_id: shelf.id, item: attributes_for(:shelf_item)
      end

      it { should respond_with 201 }
      it { should render_template 'shelves/show' }
      it { should assign_to(:shelf).with shelf }
      specify { shelf.reload.item_ids.should eq [ShelfItem.first.item_id] }
      specify { shelf.reload.shelf_items.first.item_id.should eq ShelfItem.first.item_id }
    end
  end

  describe '#destroy' do
    context 'when not logged in' do
      before do
        delete :destroy, shelf_id: shelf_item.shelf.id, id: shelf_item.item_id
      end

      it { should respond_with 401 }
      it { should render_template nil }
      specify { ShelfItem.count.should eq 1 }
      specify { shelf_item.shelf.item_ids.should include shelf_item.item_id }
    end

    context 'when shelf does not belong to user' do
      before do
        set_token user.token
        delete :destroy, shelf_id: shelf_item.shelf.id, id: shelf_item.item_id
      end

      it { should respond_with 401 }
      it { should render_template nil }
      specify { ShelfItem.count.should eq 1 }
      specify { shelf_item.shelf.item_ids.should include shelf_item.item_id }
    end

    context 'when shelf belongs to user' do
      before do
        set_token shelf_item.shelf.user.token
        delete :destroy, shelf_id: shelf_item.shelf.id, id: shelf_item.item_id
      end

      it { should respond_with 204 }
      it { should render_template nil }
      specify { ShelfItem.count.should eq 0 }
      specify {
        shelf_item.shelf.reload.item_ids.should_not include shelf_item.item_id
      }
    end
  end
end
