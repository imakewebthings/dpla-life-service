FactoryGirl.define do
  factory :date_range do |f|
    book
    start "1999-04-02"
    self.end "1999-04-02"
  end
end