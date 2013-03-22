class ShelfBooksController < ApplicationController
  before_filter :auth_and_get_user, only: [:create, :destroy]
  before_filter :get_shelf, only: [:create, :destroy]

  def create
    if @shelf.user == @user
      @shelf.shelf_books.create! book_id: params[:id]
      @shelf.book_ids.push(params[:id]).uniq!
      @shelf.save
      render 'shelves/show', status: 201
    else
      head 401
    end
  end

  def destroy
    if @shelf.user == @user
      shelf_book = @shelf.shelf_books.find_by_book_id params[:id]
      shelf_book.destroy
      @shelf.book_ids.delete params[:id]
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