require 'spec_helper'

describe UsersController do
  describe '#create' do
    context 'with valid user attributes' do
      before do
        post :create, user: attributes_for(:user)
      end

      it { should respond_with 201 }
      it { should render_template :show }
      it { should assign_to :user }
      specify { User.count.should eq 1 }
    end

    context 'with invalid user attributes' do
      before do
        post :create, user: attributes_for(:user, email: nil)
      end

      it { should respond_with 422 }
      it { should render_template 'errors/422' }
    end
  end
end