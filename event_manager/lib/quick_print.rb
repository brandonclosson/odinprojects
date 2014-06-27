require 'csv'

contents = File.readlines "lib/event_attendees.csv"

contents.each do |r|
  puts r
end