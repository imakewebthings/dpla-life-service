class ShelvesController < ApplicationController
  before_filter :get_user, only: [:index]
  before_filter :auth_and_get_user, only: [:create]
  before_filter :get_shelf, only: [:show]

  def index
    @shelves = Shelf.where({ user_id: params[:user_id] })
  end

  def show
  end

  def create
    @shelf = @user.shelves.create! params[:shelf]
    render :show, status: 201
  end

  def update
  end

  def destroy
  end

  private
    def get_user
      @user = User.find params[:user_id]
    end

    def get_shelf
      @shelf = Shelf.find params[:id]
    end
end