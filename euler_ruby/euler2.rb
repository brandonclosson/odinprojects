def sum_of_even(max_number)
  fib = [0,1]
  fib << fib[-1] + fib[-2] until fib[-1] >= max_number
  fib.select { |e| e.even? }.reduce(:+)
end