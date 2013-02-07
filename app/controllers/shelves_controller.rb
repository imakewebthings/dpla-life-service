class ShelvesController < ApplicationController
  before_filter :get_user, only: [:index]
  before_filter :auth_and_get_user, only: [:create, :update, :destroy, :push]
  before_filter :get_shelf, only: [:show, :update, :destroy, :push]

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
    if @shelf.user == @user
      @shelf.update_attributes! params[:shelf]
      render :show
    else
      head 401
    end
  end

  def destroy
    if @shelf.user == @user
      @shelf.destroy
      head 204
    else
      head 401
    end
  end

  def push
    if @shelf.user == @user
      @shelf.book_ids.push(params[:book_id]).uniq
      @shelf.save
      render :show, status: 201
    else
      head 401
    end
  end

  private
    def get_user
      @user = User.find params[:user_id]
    end

    def get_shelf
      @shelf = Shelf.find params[:id]
    end
end