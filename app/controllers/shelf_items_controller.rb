class ShelfItemsController < ApplicationController
  before_filter :auth_and_get_user, only: [:create, :destroy]
  before_filter :get_shelf, only: [:create, :destroy]

  def create
    if @shelf.user == @user
      @shelf.shelf_items.create! params[:item]
      @shelf.item_ids.push(params[:item][:item_id]).uniq!
      @shelf.save
      render 'shelves/show', status: 201
    else
      head 401
    end
  end

  def destroy
    if @shelf.user == @user
      shelf_item = @shelf.shelf_items.find_by_item_id params[:id]
      shelf_item.destroy
      @shelf.item_ids.delete params[:id]
      @shelf.save
      head 204
    else
      head 401
    end
  end

  private
    def get_shelf
      @shelf = Shelf.find params[:shelf_id]
    end
end