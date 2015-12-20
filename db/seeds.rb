# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:


input = File.open(File.join(Rails.root, "db", "moviestxt.txt"))
input.each_line do |line|
  values = line.split(" ")
  length = values.length

  id = values.first.to_i
  popularity = values.last.to_i
  year = values[length - 2].delete('()').to_i
  title = values[1..length-3].join(" ");

  #puts "ID: #{id}, title: #{title}, year: #{year}, popularity: #{popularity}"

  #  Movie.create(:movie_id => id, :title => title, :year => year, :movie_popularity => popularity)
end

input = File.open(File.join(Rails.root, "db", "tagstxt.txt"))
input.each_line do |line|
  values = line.split(" ")
  length = values.length

  id = values.first.to_i
  popularity = values.last.to_i
  name = values[1..length-2].join(" ")

  puts "ID: #{id}, name: #{name}, popularity: #{popularity}"
  if (popularity > 50)
 #   Tag.create(:tag_id => id, :name => name, :tag_popularity => popularity)
  end
end

input = File.open(File.join(Rails.root, "db", "tag_relevancetxt.txt"))
inserts = []

input.each_line do |line|

  values = line.split(" ")
  length = values.length

  movie_id = values[0].to_i
  tag_id = values[1].to_i
  relevance = values.last.to_f

  tag_array = Tag.all.pluck(:id)
  #puts "Movie ID: #{movie_id}, Tag ID: #{tag_id}, relevance: #{relevance}"
  if (tag_array.include?(tag_id))
  #  inserts.push "(#{movie_id}, #{tag_id}, #{relevance})"
  end
end

#sql = "INSERT INTO movie_tags (`movie_id`, `tag_id`, `relevance`) VALUES #{inserts.join(", ")}"




# trebaće mi

#inserts = []
#TIMES.times do
#  inserts.push "(#{movie_id}, #{tag_id}, #{relevance})"
#end
#sql = "INSERT INTO movie_tags (`movie_id`, `tag_id`, `relevance`) VALUES #{inserts.join(", ")}"
