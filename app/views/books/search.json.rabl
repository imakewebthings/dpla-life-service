object @results

attributes :start, :limit, :num_found
child(:books => :docs) do
  attribute :source_id, :cover_small, :title, :shelfrank, :pub_date, :subjects,
            :measurement_height_numeric, :measurement_page_numeric
  attribute :source_url => :link
  node(:creator) {|book| book.creator ? [book.creator] : nil }
end