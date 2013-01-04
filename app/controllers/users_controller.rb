class UsersController < ApplicationController
  def create
    @user = User.create! params[:user]
    render :session, status: 201
  end
end