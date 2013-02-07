class SessionsController < ApplicationController
  before_filter :auth_and_get_user, only: [:destroy, :show]

  def create
    @user = User.find_by_email params[:session][:email]

    if @user && @user.authenticate(params[:session][:password])
      unless @user.token
        @user.generate_token
        @user.save
      end
      render 'users/session'
    else
      head 401
    end
  end

  def destroy
    @user.token = nil
    @user.save
    head 204
  end

  def show
    render 'users/session'
  end
end