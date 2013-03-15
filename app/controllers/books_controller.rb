require 'ostruct'
require 'open-uri'
require 'json'

class BooksController < ApplicationController
  before_filter :extend_for_book_source

  def show
    @book = Book.find_by_source_id! params[:id]
  end

  def search
    if params[:search_type] == 'keyword'
      offset = (params[:start] || 0).to_i
      @limit = (params[:limit] || 10).to_i
      @start =  offset + @limit

      if params[:query] == 'empty'
        @books = []
        @num_found = 0
      else
        if (params[:start] == '-1')
          @books = Book.all
        else
          @books = Book.offset(offset).limit(@limit)
        end
        @num_found = Book.all.length
      end
      
      check_last_page
    elsif params[:search_type] == 'subject'
      @limit = (params[:limit] || 10).to_i
      @start =  -1
      @books = Book.where('subjects LIKE ?', "%#{params[:query]}%").all
      @num_found = @books.length
    elsif params[:ids]
      @limit = 0
      @start = -1
      unsorted_books = Book.where(:source_id => params[:ids])
      @books = params[:ids].collect do |id|
        unsorted_books.detect {|x| x[:source_id] == id}
      end
      @num_found = @books.length
    end
  end

  def check_last_page
    if @books.empty? or @books.length < @limit
      @start = -1
    end
  end

  def extend_for_book_source
    case Rails.configuration.book_source
    when 'hathi'
      self.extend HathiBooks
    when 'openlibrary'
      self.extend OpenLibraryBooks
    end
  end

  module HathiBooks
    def show
      url = "http://librarycloud.harvard.edu/v1/api/item/#{params[:id]}"
      json = JSON.parse(open(url).read)['docs'][0]
      @book = response_to_book json
    end

    def search
      if params[:query]
        start = (params[:start] || 0).to_i
        limit = (params[:limit] || 10).to_i
        url = 'http://librarycloud.harvard.edu/v1/api/item/?filter=collection:hathitrust_org_pd_bks_online&'
        query = {
          :limit => limit,
          :start => start
        }
        if params[:search_type] == 'subject'
          query[:filter] = "note:#{params[:query]}"
        else
          query[:filter] = "keyword:#{params[:query]}"
        end
        url += query.to_query
        json = JSON.parse(open(url).read)
        @limit = limit
        @start = start + limit
        @num_found = json['num_found']
        @books = json['docs'].collect {|x| response_to_book x }
        check_last_page
        @books.compact!
      elsif params[:ids]
        # TODO: Can LC get ID batches?
      end
    end

    # Turns a raw JSON response into an OpenStruct object for view rendering
    # while normalizing data. Items without a title are thrown out.
    def response_to_book(json)
      return nil unless json and json['title']
      url = json['url'][0] if json['url']
      puts json['pages_numeric']
      OpenStruct.new(
        :source_id => json['id'],
        :title => json['title'],
        :publisher => nil,
        :creator => json['creator'] && json['creator'].join('; '),
        :description => nil,
        :source_url => url,
        :viewer_url => url,
        :cover_small => nil,
        :cover_large => nil,
        :pub_date => json['pub_date_numeric'],
        :shelfrank => json['shelfrank'] || 1,
        :subjects => json['note'],
        :measurement_height_numeric => transform_age_to_height(json['pub_date_numeric']),
        :measurement_page_numeric => json['pages_numeric']
      )
    end

    def transform_age_to_height(pub_date)
      min_height = 20
      max_height = 39
      min_pub = 1850
      max_pub = 2013
      pub_range = max_pub - min_pub
      height_range = max_height - min_height
      return min_height unless pub_date
      translated_value = (((pub_date - min_pub) * height_range) / pub_range) + min_height
      max_height - translated_value + min_height

    end
  end

  module OpenLibraryBooks
    def show
      book_json = Openlibrary::Data.find_by_isbn params[:id]
      @book = OpenStruct.new(
        :source_id => params[:id],
        :title => [book_json.title, book_json.subtitle].compact,
        :publisher => book_json.publishers.map{|p| p['name'] },
        :creator => book_json.authors[0]['name'],
        :description => nil,
        :source_url => book_json.url,
        :viewer_url => book_json.url
      )
    end

    def search
    end
  end
end