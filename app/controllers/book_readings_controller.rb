class BookReadingsController < ApplicationController
  require 'ostruct'

  def create
    reading = BookReading.new
    reading.book_id = params[:book_id]
    reading.save!
    head 204
  end
end