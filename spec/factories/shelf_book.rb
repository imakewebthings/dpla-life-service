FactoryGirl.define do
  factory :shelf_book do |f|
    shelf
    sequence(:item_id) {|n| "item-id-#{n}" }

    after :create do |shelf_book|
      shelf_book.shelf.book_ids.push shelf_book.item_id
      shelf_book.shelf.save
    end
  end
end