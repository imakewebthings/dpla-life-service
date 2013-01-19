require 'spec_helper'

describe ReviewsController do
  let(:user) { create :user }
  let(:book) { create :book }
  let(:review) { create(:review, book_id: book._id )}

  describe '#index' do
    before do
      review
      get :index, book_id: book._id
    end

    it { should respond_with 200 }
    it { should render_template :index }
    it { should assign_to(:reviews).with [review] }
  end

  describe '#show' do
    before do
      get :show, id: review.id
    end

    it { should respond_with 200 }
    it { should render_template :show }
    it { should assign_to(:review).with review }
  end

  describe '#create' do
    context 'as an unregistered user' do
      before do
        post :create, book_id: book._id, review: attributes_for(:review)
      end

      it { should respond_with 401 }
      it { should render_template nil }
      specify { Review.count.should eq 0 }
    end

    context 'as a registered user' do
      before do
        set_token user.token
        post :create, book_id: book._id, review: attributes_for(:review)
      end

      it { should respond_with 201 }
      it { should render_template :show }
      it { should assign_to :review }
      specify { Review.count.should eq 1 }
    end

    context 'with invalid attributes' do
      before do
        set_token user.token
        post :create, book_id: book._id,
                      review: attributes_for(:review, rating: nil)
      end

      it { should respond_with 422 }
      it { should render_template 'errors/422' }
      specify { Review.count.should eq 0 }
    end
  end

  describe '#update' do
    context 'as an unregistered user' do
      before do
        put :update, id: review.id, review: { rating: 2 }
        review.reload
      end

      it { should respond_with 401 }
      it { should render_template nil }
      specify { review.rating.should_not eq 2 }
    end

    context 'as a registered user' do
      before do
        set_token review.user.token
        put :update, id: review.id, review: { rating: 2 }
        review.reload
      end

      it { should respond_with 200 }
      it { should render_template :show }
      it { should assign_to :review }
      specify { review.rating.should eq 2 }
    end

    context 'with invalid attributes' do
      before do
        set_token review.user.token
        put :update, id: review.id, review: { rating: 999 }
        review.reload
      end

      it { should respond_with 422 }
      it { should render_template 'errors/422' }
      specify { review.rating.should_not eq 999 }
    end
  end

  describe '#destroy' do
    context 'as an unregistered user' do
      before do
        delete :destroy, id: review.id
      end

      it { should respond_with 401 }
      it { should render_template nil }
      specify { Review.count.should eq 1 }
    end

    context 'as a registered user' do
      before do
        set_token review.user.token
        delete :destroy, id: review.id
      end

      it { should respond_with 204 }
      it { should render_template nil }
      specify { Review.count.should eq 0 }
    end
  end
end