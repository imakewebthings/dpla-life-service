FactoryGirl.define do
  factory :shelf_book do |f|
    shelf
    sequence(:book_id) {|n| "book-id-#{n}" }

    after :create do |shelf_book|
      shelf_book.shelf.book_ids.push shelf_book.book_id
      shelf_book.shelf.save
    end
  end
end