class BookReadingsController < ApplicationController
  require 'ostruct'

  def create
    reading = BookReading.new
    reading.book_id = params[:book_id]
    reading.save!
    head 204
  end

  def index
    @book_readings = OpenStruct.new

    @book_readings.books = BookReading
      .select('book_id')
      .where(created_at: (Time.now - 4.weeks)..Time.now)
      .group('book_id')
      .order('count_book_id DESC')
      .count('book_id')
  end
end