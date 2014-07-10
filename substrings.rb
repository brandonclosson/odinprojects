def substrings(words, dictionary)
  count = Hash.new(0)
  words.downcase!

  dictionary.each do |substring|
    occurences = words.scan(/#{substring.downcase}/).length
    count[substring] = occurences if occurences > 0
  end

  count
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings "low", dictionary
puts substrings "Howdy partner, sit down! How's it going?", dictionary