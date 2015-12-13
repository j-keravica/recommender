# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# input = File.open(File.join(Rails.root, "db", "moviestxt.txt"))
# input.each_line do |line|
#   values = line.split(" ")
#   length = values.length

#   id = values.first.to_i
#   popularity = values.last.to_i
#   year = values[length - 2].delete('()').to_i
#   title = values[1..length-3].join(" ");

#   # puts "ID: #{id}, title: #{title}, year: #{year}, popularity: #{popularity}"

#   Movie.create(:movie_id => id, :title => title, :year => year, :movie_popularity => popularity)
# end

# input = File.open(File.join(Rails.root, "db", "tagstxt.txt"))
# input.each_line do |line|
#   values = line.split(" ")
#   length = values.length

#   id = values.first.to_i
#   popularity = values.last.to_i
#   name = values[1..length-2].join(" ")

#   # puts "ID: #{id}, name: #{name}, popularity: #{popularity}"

#   Tag.create(:tag_id => id, :name => name, :tag_popularity => popularity)
# end

input = File.open(File.join(Rails.root, "db", "tag_relevancetxt.txt"))
i = 0
t = 0
tuples = []

input.each_line do |line|

  values = line.split(" ")
  length = values.length

  movie_id = values[0].to_i
  tag_id = values[1].to_i
  relevance = values.last.to_f

  # puts "Movie ID: #{movie_id}, Tag ID: #{tag_id}, relevance: #{relevance}"

  if (movie_id >= 107141)
    tuples << MovieTag.new(:movie_id => movie_id, :tag_id => tag_id, :relevance => relevance)
    i += 1
  end

  if i >= 1000
    MovieTag.import tuples
    t += i
    puts "Imported #{t} tuples"
    i = 0
    tuples = []
  end
end

MovieTag.import tuples