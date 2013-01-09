FactoryGirl.define do
  factory :book do |f|
    sequence(:_id) {|n| "sample-_id-#{n}" }
  end
end