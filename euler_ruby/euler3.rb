def largest_prime_factor(number)
  x = number
  (1..Math.sqrt(x).to_i).each do |e|
    break if x <= e
    x /= e if (e < x and x % e == 0)
  end
  x
end

puts largest_prime_factor(600851475143)