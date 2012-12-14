# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

500.times do |n|
  title = []
  (1 + rand(1)).times do
    title.push Faker::Lorem.words.join(' ').titleize
  end

  publisher = []
  (1 + rand(1)).times do
    publisher.push "#{Faker::Lorem.words(2).join(' ').titleize} Publishing"
  end

  book = Book.create({
    :@id => "http://dpla.example.org/books/#{n}",
    :title => title,
    :creator => "#{Faker::Name.last_name}, #{Faker::Name.first_name}",
    :publisher => publisher,
    :description => Faker::Lorem.paragraph,
    :source => 'http://dpla.example.org'
  }, :without_protection => true)

  (1 + rand(2)).times do
    date = "#{1800 + rand(200)}-02-14"
    DateRange.create({
      :book_id => book.id,
      :start => date,
      :end => date
    }, :without_protection => true)
  end
end
