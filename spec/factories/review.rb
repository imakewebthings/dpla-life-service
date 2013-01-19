FactoryGirl.define do
  factory :review do |f|
    book_id 'some-book-id'
    user
    rating 5
  end
end