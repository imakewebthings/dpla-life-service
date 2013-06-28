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
end
