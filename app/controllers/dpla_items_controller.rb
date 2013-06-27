class DplaItemsController < ApplicationController
  require 'open-uri'
  require 'json'
  require 'ostruct'

  def index
    @dpla_items = OpenStruct.new JSON.parse(open(search_url).read)
  end

  def show
    @dpla_item = OpenStruct.new JSON.parse(open(item_url).read)['docs'][0]
  end

  private
    def base_url
      "http://api.dp.la/v2/"
    end

    def search_url
      [ base_url,
        "items?api_key=#{Rails.configuration.dpla_api_key}&",
        params.slice(:q).to_query,
        '&sourceResource.type=image+OR+sound+OR+moving+image&page_size=20'
      ].join
    end

    def item_url
      "#{base_url}items/#{params[:id]}?api_key=#{Rails.configuration.dpla_api_key}"
    end
end