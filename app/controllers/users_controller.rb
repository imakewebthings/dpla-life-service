class UsersController < ApplicationController
  before_filter :auth_and_get_user, only: [:destroy, :update]

  def create
    @user = User.create! params[:user]
    render :session, status: 201
  end

  def destroy
    @user.destroy
    head 204
  end

  def update
    @user.update_attributes! params[:user]
    render :show
  end
end