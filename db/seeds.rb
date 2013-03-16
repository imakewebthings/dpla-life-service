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
  title = title.join(' - ')

  publisher = []
  (1 + rand(2)).times do # 1 or 2 publishers
    publisher.push "#{Faker::Lorem.words(2).join(' ').titleize} Publishing"
  end
  publisher = publisher.join(' - ')

  viewer_url = rand(2) == 1 ? 'http://viewer.example.org/' : nil

  cover_small = nil
  cover_large = nil
  if rand(2) == 1
    cover_small = 'http://placehold.it/300x486'
    cover_large = 'http://placehold.it/640x1036'
  end

  subjects = ['science', 'mathematics', 'language', 'history', 'misc']

  book = Book.create({
    :source_id => "book-#{n}",
    :title => title,
    :creator => "#{Faker::Name.last_name}, #{Faker::Name.first_name}",
    :publisher => publisher,
    :description => Faker::Lorem.paragraph,
    :source_url => 'http://source.example.org',
    :viewer_url => viewer_url,
    :cover_small => cover_small,
    :cover_large => cover_large,
    :shelfrank => rand(98) + 1,
    :subjects => subjects.sort_by{rand}[0..1],
    :pub_date => Time.now.year - rand(100),
    :measurement_height_numeric => rand(19) + 20,
    :measurement_page_numeric => rand(300) + 100
  }, :without_protection => true)
end
