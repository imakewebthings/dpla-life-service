FactoryGirl.define do
  factory :book do |f|
    sequence(:source_id) {|n| "sample-_id-#{n}" }
  end
end