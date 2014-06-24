require 'rest-client'

puts "What do you want to search for?"
input = gets.chomp.strip
result = RestClient.get "https://www.google.com/search?q=#{input.gsub(" ", "+")}"
puts result