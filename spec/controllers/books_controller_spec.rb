require 'spec_helper'

describe BooksController do
  let (:book) { create :book }

  describe '#show' do
    context 'when book exists' do
      before do
        get :show, id: book._id
      end

      it { should respond_with 200 }
      it { should render_template :show }
      it { should assign_to(:book).with book }
    end

    context 'when book does not exist' do
      before do
        get :show, id: 'does-not-exist'
      end

      it { should respond_with 404 }
      it { should render_template nil }
    end
  end
end