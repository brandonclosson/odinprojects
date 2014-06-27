require "csv"
require "sunlight/congress"
require "erb"

Sunlight::Congress.api_key = "3915c2d857e84b688fe383214a4a1b91"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phone_number(number)
  number = number.to_s.gsub(/[^0-9]/, "")
  if number.length == 10
    return number[0..2] + "." + number[3..5] + "." + number[6..9]
  elsif number.length == 11 && number[0] == "1"
    return number[1..3] + "." + number[4..6] + "." + number[7..10]
  end
  "Bad Entry"
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def create_and_save_letter(id, form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")
  filename = "thank_you_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end

  filename
end

def find_most_popular_hour(hours_hash)
  hours_hash.select do |hour, number_of_registrations|
    number_of_registrations == hours_hash.values.max
  end.keys.join(', ')
end

def find_most_popular_weekday(weekday_hash)
  weekdays = %w{ Sunday Monday Tuesday Wednesday Thursday Friday Saturday }

  weekday_hash.select do |day, number_of_registrations|
    number_of_registrations == weekday_hash.values.max
  end.keys.map { |day_index| weekdays[day_index] }.join(', ')
end

puts "EventManager initialized."
contents = CSV.open "lib/event_attendees.csv", headers: true, header_converters: :symbol
template = File.read "form_letter.erb"
erb_template = ERB.new template
registration_dates = []

hours = Hash.new(0)
weekdays = Hash.new(0)

contents.each do |row|
  id = row[0]
  first_name = row[:first_name]
  last_name = row[:last_name]
  name = first_name + " " + last_name
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)

  datetime = DateTime.strptime(row[:regdate], '%m/%d/%Y %H:%M')
  registration_dates.push(datetime)

  form_letter = erb_template.result(binding)
  filename = create_and_save_letter(id, form_letter)

  hours[datetime.hour] += 1
  weekdays[datetime.wday] += 1

  puts "Created #{filename}\n\tfor #{name}, tel: #{phone_number}"
end

puts "\n\nRegistration Analytics\n----------------------------"
puts "Most popular hour for registration(24-hour clock): #{find_most_popular_hour(hours)}"
puts "Most popular week day for registration: #{find_most_popular_weekday(weekdays)}"
