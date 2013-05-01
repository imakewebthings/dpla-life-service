FactoryGirl.define do
  factory :book_reading do |f|
    sequence(:book_id) {|n| "book-id-#{n}" }
    created_at DateTime.now
  end
end