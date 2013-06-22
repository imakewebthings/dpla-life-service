require 'spec_helper'

describe DplaItemsController do
  describe '#index' do
    before do
      @stub = stub_request(:get, "http://api.dp.la/v2/items?api_key=mockkey&q=thing&sourceResource.type=image")
        .to_return(body: '{}')
      get :index, q: 'thing'
    end

    specify { @stub.should have_been_requested }
    it { should assign_to :dpla_items }
  end

  describe '#show' do
    before do
      @stub = stub_request(:get, "http://api.dp.la/v2/items/1?api_key=mockkey")
        .to_return(body: '{"docs":[]}')
      get :show, id: 1
    end

    specify { @stub.should have_been_requested }
    it { should assign_to :dpla_item }
  end
end