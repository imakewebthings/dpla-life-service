require 'spec_helper'

describe SearchesController do
  describe '#show' do
    before :each do
      5.times { create :book }
    end

    context 'with empty result set' do
      before do
        get :show, query: 'empty'
      end

      it { should respond_with 200 }
      it { should render_template :show }
      it { should assign_to(:books).with [] }
      it { should assign_to(:num_found).with 0 }
      it { should assign_to(:start).with -1 }
      it { should assign_to(:limit).with 10 }
    end

    context 'with results' do
      context 'on first page' do
        before do
          get :show, query: 'foo', start: 0, limit: 2
        end

        it { should assign_to(:books).with Book.offset(0).limit(2) }
        it { should assign_to(:num_found).with 5 }
        it { should assign_to(:start).with 2 }
        it { should assign_to(:limit).with 2 }
      end

      context 'on middle page' do
        before do
          get :show, query: 'foo', start: 2, limit: 2
        end

        it { should assign_to(:books).with Book.offset(2).limit(2) }
        it { should assign_to(:num_found).with 5 }
        it { should assign_to(:start).with 4 }
        it { should assign_to(:limit).with 2 }
      end

      context 'on last page' do
        before do
          get :show, query: 'foo', start: 4, limit: 2
        end

        it { should assign_to(:books).with Book.offset(4).limit(2) }
        it { should assign_to(:num_found).with 5 }
        it { should assign_to(:start).with -1 }
        it { should assign_to(:limit).with 2 }
      end
    end
  end
end