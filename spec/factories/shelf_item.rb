FactoryGirl.define do
  factory :shelf_item do |f|
    shelf
    sequence(:item_id) {|n| "item-id-#{n}" }
    source 'book_source'
    item_type 'book'

    after :create do |shelf_item|
      shelf_item.shelf.item_ids.push shelf_item.item_id
      shelf_item.shelf.save
    end
  end
end