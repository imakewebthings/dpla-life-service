FactoryGirl.define do
  factory :book do |f|
    sequence(:@id) {|n| "sample-@id-#{n}" }
  end
end