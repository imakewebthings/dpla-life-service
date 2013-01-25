# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

Book.destroy_all

500.times do |n|
  title = []
  (1 + rand(2)).times do # 1 or 2 titles (subtitle)
    title.push Faker::Lorem.words.join(' ').titleize
  end

  publisher = []
  (1 + rand(2)).times do # 1 or 2 publishers
    publisher.push "#{Faker::Lorem.words(2).join(' ').titleize} Publishing"
  end

  viewer_url = rand(2) == 1 ? 'http://viewer.example.org/' : nil

  book = Book.create({
    :_id => "book-#{n}",
    :title => title,
    :creator => "#{Faker::Name.last_name}, #{Faker::Name.first_name}",
    :publisher => publisher,
    :description => Faker::Lorem.paragraph,
    :dplaLocation => 'http://source.example.org',
    :viewer_url => viewer_url
  }, :without_protection => true)

  (1 + rand(3)).times do #Between 1-3 temporal dates for each book
    date = "#{1800 + rand(200)}-02-14"
    DateRange.create({
      :book_id => book.id,
      :start => date,
      :end => date
    }, :without_protection => true)
  end
end
