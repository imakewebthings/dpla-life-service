FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user-#{n}@example.org" }
    password 'foopass8'
    password_confirmation 'foopass8'
  end
end