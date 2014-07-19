def bubble_sort(numbers)

  (2..(numbers.size - 1)).to_a.reverse.each do |i|
    (0...i).to_a.each do |index|
      num1 = numbers[index]
      num2 = numbers[index + 1]
      switch = Proc.new {numbers[index] = num2; numbers[index + 1] = num1 }
      
      block_given? ? (switch.call if (yield num1, num2) < 0) : (switch.call if num2 < num1)
    end
  end
  numbers
end

print bubble_sort([10, 3, 7, 11, 2, 19, 5, 6])
print bubble_sort(["hello", "h", "hey", "he", "hell"]) { |left, right| right.length - left.length }