class ShelvesController < ApplicationController
  require 'open-uri'
  require 'json'
  require 'ostruct'

  before_filter :get_user, only: [:index]
  before_filter :auth_and_get_user, only: [:create, :update, :destroy, :push]
  before_filter :get_shelf, only: [:show, :update, :destroy, :push]

  def index
    @shelves = Shelf.where({ user_id: params[:user_id] })
  end

  def show
    aggregate_shelf_items
  end

  def create
    @shelf = @user.shelves.create! params[:shelf]
    render :show, status: 201
  end

  def update
    if @shelf.user == @user
      @shelf.update_attributes! params[:shelf]
      aggregate_shelf_items
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

  private
    def get_user
      @user = User.find params[:user_id]
    end

    def get_shelf
      @shelf = Shelf.find params[:id]
    end

    def aggregate_shelf_items
      @items = (book_items || []) + (dpla_items || [])
      lookup = {}
      @shelf.item_ids.each_with_index do |id, index|
        lookup[id] = index
      end
      @items.sort_by! do |item|
        lookup.fetch item.source_id
      end
    end

    def book_items
      books = @shelf.shelf_items.where(source: 'book_source')
      return [] if books.nil?

      case Rails.configuration.book_source
      when 'librarycloud'
        require 'books/librarycloud'
        Librarycloud.new({
          ids: books.pluck('item_id').join(',')
        }).search_by_ids['books']
      else
        require 'books/mocklib'
        Mocklib.new({
          ids: books.pluck('item_id').join(',')
        }).search_by_ids['books']
      end
    end

    def dpla_items
      dpla_ids = @shelf.shelf_items.where(source: 'dpla').pluck('item_id')
      return [] if dpla_ids.nil?
      url = "http://api.dp.la/v2/items/#{dpla_ids.join(',')}?api_key=#{Rails.configuration.dpla_api_key}&page_size=100"
      JSON.parse(open(url).read)['docs']
    end
end