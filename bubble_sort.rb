def bubble_sort(numbers)
  (2..(numbers.size - 1)).to_a.reverse.each do |i|
    (0...i).to_a.each do |index|
      num1 = numbers[index]
      num2 = numbers[index + 1]
      if num2 < num1
        numbers[index] = num2
        numbers[index + 1] = num1
      end
    end
  end
  numbers
end

print bubble_sort([10, 3, 7, 11, 2, 19, 5, 6])