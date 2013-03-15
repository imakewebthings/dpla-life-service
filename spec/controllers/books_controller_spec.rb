require 'spec_helper'

describe BooksController do
  describe '#show' do
    let (:book) { create :book }

    context 'when book exists' do
      before do
        get :show, id: book.source_id
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

  describe '#search' do
    before do
      5.times { create :book }
    end

    context 'by title' do
      context 'with empty result set' do
        before do
          get :search, query: 'empty', search_type: 'keyword'
        end

        it { should respond_with 200 }
        it { should render_template 'books/search' }
        it { should assign_to(:books).with [] }
        it { should assign_to(:num_found).with 0 }
        it { should assign_to(:start).with -1 }
        it { should assign_to(:limit).with 10 }
      end

      context 'with results' do
        context 'on first page' do
          before do
            get :search, query: 'foo', search_type: 'keyword',
                         start: 0, limit: 2
          end

          it { should assign_to(:books).with Book.offset(0).limit(2) }
          it { should assign_to(:num_found).with 5 }
          it { should assign_to(:start).with 2 }
          it { should assign_to(:limit).with 2 }
        end

        context 'on middle page' do
          before do
            get :search, query: 'foo', search_type: 'keyword',
                         start: 2, limit: 2
          end

          it { should assign_to(:books).with Book.offset(2).limit(2) }
          it { should assign_to(:num_found).with 5 }
          it { should assign_to(:start).with 4 }
          it { should assign_to(:limit).with 2 }
        end

        context 'on last page' do
          before do
            get :search, query: 'foo', search_type: 'keyword',
                         start: 4, limit: 2
          end

          it { should assign_to(:books).with Book.offset(4).limit(2) }
          it { should assign_to(:num_found).with 5 }
          it { should assign_to(:start).with -1 }
          it { should assign_to(:limit).with 2 }
        end
      end
    end

    describe 'with ids param' do
      before do
        get :search, ids: [Book.first[:source_id], Book.last[:source_id]]
      end

      it { should respond_with 200 }
      it { should assign_to(:books).with [Book.first, Book.last] }
      it { should assign_to(:num_found).with 2 }
    end

    describe 'by subject' do
      before do
        create :book, :subjects => ['test']
        get :search, query: 'test', search_type: 'subject'
      end

      it { should respond_with 200 }
      it { should assign_to(:books).with [Book.last] }
      it { should assign_to(:num_found).with 1 }
    end
  end
end