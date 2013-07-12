FactoryGirl.define do
  factory :shelf_item do |f|
    shelf
    sequence(:item_id) {|n| "item-id-#{n}" }

    after :create do |shelf_item|
      shelf_item.shelf.book_ids.push shelf_item.item_id
      shelf_item.shelf.save
    end
  end
end