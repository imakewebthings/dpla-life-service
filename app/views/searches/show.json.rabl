object false
node(:start) { @start }
node(:limit) { @limit }
node(:num_found) { @num_found }
child(@books => :docs) do
  attribute :@id
  attribute :source => :link
  node(:title) {|book| book.title.join(' - ') }
  node(:creator) {|book| [book.creator] }
  node(:pub_date) {|book| book.temporals[0].start.split('-')[0] }
end