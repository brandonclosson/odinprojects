def cypher(user_string = "This is the default string.", n = 5)
  lower_letters = ('a'..'z').to_a
  upper_letters = ('A'..'Z').to_a
  alphabets = [lower_letters, upper_letters]
  both_alphabets = lower_letters + upper_letters
  encrypted = ""

  user_string.split('').each do |char|
    alphabets.each do |a|
      if a.include? char
        new_index = (a.index { |c| c == char }) + n
        new_index %= a.size if new_index > a.size - 1
        encrypted << a[new_index]
      end
    end
  end

  encrypted
end

puts "Enter your string: "
string_input = gets.chomp
puts string_input

cypher_input = 0
until cypher_input.is_a?(Integer) && cypher_input > 0
  puts "Enter a number greater than 0: "
  cypher_input = gets.chomp.to_i
end

puts cypher(string_input, cypher_input)