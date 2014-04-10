def find_sum_of_multiples_of_three_and_five(max_number)
  (0..max_number).select do |number|
    number % 3 == 0 || number % 5 == 0
  end.reduce(:+)
end