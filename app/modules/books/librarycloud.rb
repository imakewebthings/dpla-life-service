class Librarycloud
  require 'ostruct'
  require 'open-uri'
  require 'json'

  def initialize(params)
    @params = params
  end

  def single_book
    url = base_url + "/v1/api/item/#{@params[:id]}"
    json = JSON.parse(open(url).read)['docs'][0]
    @book = json_to_book json
  end

  def search_by_keyword
    url = build_search_url :filter => "keyword:#{@params[:query]}"
    json = JSON.parse(open(url).read)
    json_to_response json
    format_results
  end

  def search_by_title
    url = build_search_url :filter => "title_keyword:#{@params[:query]}"
    json = JSON.parse(open(url).read)
    json_to_response json
    format_results
  end

  def search_by_author
    url = build_search_url :filter => "creator_keyword:#{@params[:query]}"
    json = JSON.parse(open(url).read)
    json_to_response json
    format_results
  end

  def search_by_subject
    url = build_search_url :filter => "note:#{@params[:query]}"
    json = JSON.parse(open(url).read)
    json_to_response json
    format_results
  end

  def search_by_subject_union
    subjects = fetch_book_subjects @params[:query]
    if subjects.blank?
      empty_response
    else
      @num_found = 0
      @books = subjects.collect do |subject|
        subject_url = build_search_url :filter => "note:#{subject}"
        json = JSON.parse(open(subject_url).read)
        @num_found += json['num_found']
        json['docs']
      end.flatten.uniq do |book|
        book['id']
      end.collect {|book| json_to_book book }
      @limit = param_limit
      @start = param_start + param_limit
      check_last_page
    end
    format_results
  end

  def search_by_subject_intersection
    subjects = fetch_book_subjects @params[:query]
    if subjects.blank?
      empty_response
    else
      url = build_search_url
      subject_filters = subjects.collect do |subject|
        { :filter => "note:#{subject}" }.to_query
      end
      url = url + '&' + subject_filters.join('&')
      json = JSON.parse(open(url).read)
      json_to_response json
    end
    format_results
  end

  def search_by_ids
    if @params[:query].blank?
      empty_response
    else
      url = build_search_url :filter => "id:#{@params[:query]}"
      json = JSON.parse(open(url).read)
      json_to_response json
      sort_by_original_ids
    end
    format_results
  end

  def recent_most_read(popular_ids)
    @params[:start] = 0
    @params[:limit] = 100
    @params[:query] = popular_ids[0..49].join(',')
    puts @params
    search_by_ids
  end

  private

    def param_start
      start = (@params[:start] || 0).to_i
    end

    def param_limit
      limit = (@params[:limit] || 10).to_i
    end

    def build_search_url(query = {})
      url = base_url + '/v1/api/item/?filter=collection:hathitrust_org_pd_bks_online,archive_org_pd_bks_online,dp_la_books_online&'
      params = { :limit => param_limit, :start => param_start }.merge query
      url + params.to_query
    end

    def base_url
      "http://librarycloud.harvard.edu"
    end

    def json_to_response(json)
      @limit = param_limit
      @start = param_start + param_limit
      @num_found = json['num_found']
      @books = json['docs'].collect {|x| json_to_book x }
      check_last_page
      @books.compact!
    end

    # Turns a raw JSON response into an OpenStruct object for view rendering
    # while normalizing data. Items without a title are thrown out.
    def json_to_book(json)
      return nil unless json and json['title']
      url = json['url'][0][/http.*$/] if json['url']
      OpenStruct.new(
        :source_id => json['id'],
        :title => json['title'],
        :publisher => nil,
        :creator => json['creator'] && json['creator'].join('; '),
        :description => nil,
        :source_url => url,
        :viewer_url => json['online_avail'] && (url + '?urlappend=%3Bui=embed'),
        :cover_small => nil,
        :cover_large => nil,
        :pub_date => json['pub_date_numeric'],
        :shelfrank => json['shelfrank'] || 1,
        :subjects => json['note'],
        :measurement_height_numeric => age_to_height(json['pub_date_numeric']),
        :measurement_page_numeric => json['pages_numeric'],
        :source_library => printable_source_record(json)
      )
    end

    def age_to_height(pub_date)
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

    def fetch_book_subjects(book_id)
      url = base_url + '/v1/api/item/' + book_id
      book = JSON.parse(open(url).read)
      book['docs'][0] && book['docs'][0]['note']
    end

    def empty_response
      @num_found = 0
      @books = []
      @limit = 0
      @start = -1
    end

    def check_last_page
      if @books.empty? or @books.length < @limit
        @start = -1
      end
    end

    def printable_source_record(json)
      return case json['source_record']['collection']
      when 'dp_la_books_online'
        'Biodiversity Heritage Library via DPLA'
      when 'archive_org_pd_bks_online'
        'Internet Archive'
      when 'hathitrust_org_pd_bks_online'
        'Hathi Trust'
      end
    end

    def sort_by_original_ids
      original_ids = @params[:query].split ','
      lookup = {}
      original_ids.each_with_index do |id, index|
        lookup[id] = index
      end
      @books.sort_by! do |book|
        lookup.fetch book.source_id
      end
    end

    def format_results
      OpenStruct.new(
        limit: @limit,
        start: @start,
        books: @books,
        num_found: @num_found
      )
    end
end