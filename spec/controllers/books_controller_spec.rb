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
        it { should assign_to(:results) }
      end

      context 'with results' do
        before do
          get :search, query: 'foo', search_type: 'keyword',
                       start: 0, limit: 2
        end

        it { should assign_to(:results) }
      end
    end

    describe 'with ids param' do
      before do
        get :search, search_type: 'ids',
                     query: "#{Book.first[:source_id]},#{Book.last[:source_id]}"
      end

      it { should respond_with 200 }
    end

    describe 'by subject' do
      before do
        create :book, :subjects => ['test']
        get :search, query: 'test', search_type: 'subject'
      end

      it { should respond_with 200 }
    end

    describe 'by subject union' do
      let!(:target_book) { create :book, :subjects => ['foo', 'bar'] }
      let!(:book2) { create :book, :subjects => ['foo'] }
      let!(:book3) { create :book, :subjects => ['bar'] }

      before do
        get :search, search_type: 'subject_union',
                     query: target_book.source_id
      end

      it { should respond_with 200 }
    end

    describe 'by subject intersection' do
      let!(:target_book) { create :book, :subjects => ['foo', 'bar'] }
      let!(:book2) { create :book, :subjects => ['foo'] }
      let!(:book3) { create :book, :subjects => ['bar'] }
      let!(:book4) { create :book, :subjects => ['foo', 'bar'] }

      before do
        get :search, search_type: 'subject_intersection',
                     query: target_book.source_id
      end

      it { should respond_with 200 }
    end
  end

  describe '#recently_read' do
    before do
      get :recent_most_read
    end

    it { should respond_with 302 }
  end
end