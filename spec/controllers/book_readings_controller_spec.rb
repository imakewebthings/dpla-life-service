require 'spec_helper'

describe BookReadingsController do
  let(:book) { create :book }

  describe '#create' do
    before do
      post :create, book_id: book.id
    end

    it { should respond_with 204 }
    it { should render_template nil }
    specify { BookReading.count.should eq 1 }
    specify { BookReading.first.book_id.should eq book.id.to_s }
  end

  describe '#index' do
    let!(:book_reading) { create :book_reading }

    before do
      get :index
    end

    it { should respond_with 200 }
    it { should render_template :index }
    it { should assign_to(:book_readings) }
  end
end
