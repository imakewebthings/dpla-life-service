class UsersController < ApplicationController
  def create
    @user = User.create! params[:user]
    render :show, status: 201
  end
end