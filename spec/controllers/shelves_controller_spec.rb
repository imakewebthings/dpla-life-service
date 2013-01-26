require 'spec_helper'

describe ShelvesController do
  let(:user) { create :user }
  let(:shelf) { create :shelf }

  describe '#index' do
    context 'with valid user id' do
      before do
        get :index, user_id: shelf.user.id
      end

      it { should respond_with 200 }
      it { should render_template :index }
      it { should assign_to(:shelves).with [shelf] }
    end

    context 'without valid user id' do
      before do
        get :index, user_id: 'nonsense-user-id'
      end

      it { should respond_with 404 }
      it { should render_template nil }
    end
  end

  describe '#show' do
    context 'with a valid shelf id' do
      before do
        get :show, id: shelf.id
      end

      it { should respond_with 200 }
      it { should render_template :show }
      it { should assign_to(:shelf).with shelf }
    end

    context 'with an invalid shelf id' do
      before do
        get :show, id: 'nonsense-id'
      end

      it { should respond_with 404 }
      it { should render_template nil }
    end
  end

  describe '#create' do
    context 'with a valid user token' do
      before do
        set_token user.token
        post :create, user_id: user.id, shelf: attributes_for(:shelf)
      end
      
      it { should respond_with 201 }
      it { should render_template :show }
      it { should assign_to :shelf }
      specify { user.shelves.length.should eq 1 }
    end

    context 'without a valid user token' do
      before do
        post :create, user_id: user.id, shelf: attributes_for(:shelf)
      end
      
      it { should respond_with 401 }
      it { should render_template nil }
      specify { user.shelves.length.should eq 0 }
    end
  end

  describe '#update' do
    it 'needs specs'
  end

  describe '#destroy' do
    it 'needs specs'
  end
end