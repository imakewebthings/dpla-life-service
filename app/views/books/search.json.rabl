object false
node(:start) { @start }
node(:limit) { @limit }
node(:num_found) { @num_found }
child(@books => :docs) do
  attribute :source_id, :cover_small, :title, :shelfrank, :pub_date
  attribute :source_url => :link
  node(:creator) {|book| book.creator ? [book.creator] : nil }
end