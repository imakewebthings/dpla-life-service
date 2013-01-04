require 'spec_helper'

describe SessionsController do
  let(:user_attrs) { attributes_for :user }
  let!(:user) { create :user, user_attrs }

  describe '#create' do
    context 'with valid credentials' do
      before do
        post :create, session: {
          email: user_attrs[:email],
          password: user_attrs[:password]
        }
      end

      it { should respond_with 200 }
      it { should render_template 'users/session' }
      it { should assign_to :user }
    end

    context 'with invalid credentials' do
      before do
        post :create, session: {
          email: nil,
          password: nil
        }
      end

      it { should respond_with 401 }
      it { should render_template nil }
    end
  end

  describe '#destroy' do
    context 'with valid session token' do
      before do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.token)
        delete :destroy
      end

      it { should respond_with 204 }
      it { should render_template nil }
      
      it 'resets user token to nil' do
        user.reload
        user.token.should be_nil
      end
    end

    context 'with invalid session token' do
      before do
        delete :destroy
      end

      it { should respond_with 401 }
      it { should render_template nil }

      it 'does not reset user token' do
        old_token = user.token
        user.reload
        user.token.should eq old_token
      end
    end
  end

  describe '#show' do
    context 'with valid session token' do
      before do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.token)
        get :show
      end

      it { should respond_with 200 }
      specify { response.body.should be_blank }
    end

    context 'with invalid session token' do
      before do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials('nonsense')
        get :show
      end

      it { should respond_with 401 }
      it { should render_template nil }
    end
  end
end