require 'spec_helper'

describe ShelfBooksController do
  let(:user) { create :user }
  let(:shelf) { create :shelf }

  describe '#create' do
    context 'when not logged in' do
      before do
        post :create, shelf_id: shelf.id, id: 1
      end

      it { should respond_with 401 }
      it { should render_template nil }
      specify { shelf.reload.book_ids.should be_blank }
      specify { shelf.reload.shelf_books.should be_blank }
    end

    context 'when shelf does not belong to user' do
      before do
        set_token user.token
        post :create, shelf_id: shelf.id, id: 1
      end

      it { should respond_with 401 }
      it { should render_template nil }
      specify { shelf.reload.book_ids.should be_blank }
      specify { shelf.reload.shelf_books.should be_blank }
    end

    context 'when shelf belongs to user' do
      before do
        set_token shelf.user.token
        post :create, shelf_id: shelf.id, id: 1
      end

      it { should respond_with 201 }
      it { should render_template 'shelves/show' }
      it { should assign_to(:shelf).with shelf }
      specify { shelf.reload.book_ids.should eq ['1'] }
      specify { shelf.reload.shelf_books.first.book_id.should eq '1' }
    end
  end
end
