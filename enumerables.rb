module Enumerable
  def my_each
    return self unless block_given?

    for element in self
      yield(element)
    end
    self
  end

  def my_each_with_index
    return self unless block_given?

    index = 0
    for element in self
      yield(index, element)
      index += 1
    end
    self
  end

  def my_select 
    return self unless block_given?
    result = self.class.new

    self.my_each do |e|
      result << e if yield(e) == true
    end
    result
  end

  def my_all?
    return true unless block_given?

    result = true
    self.my_each { |e| result = false if yield(e) == false }
    result
  end

  def my_any?
    return true unless block_given?

    result = false
    self.my_each { |e| result = true if yield(e) == true }
    result
  end

  def my_none?
    return false unless block_given?

    result = true
    self.my_each { |e| result = false if yield(e) == true }
    result
  end

  def my_count
    return self.length unless block_given?

    count = 0
    self.my_each { |e| count += 1 if yield(e) == true }
    count
  end

  def my_map(&proc)
    return self unless proc || block_given?

    if proc
      return self.my_each_with_index { |i, e| self[i] = proc.call(i, e) }
    end
    self.my_each_with_index { |i, e| self[i] = yield(e) }
  end
end

def multiply_elements(elements)
  elements.my_inject(1) { |sum, e| sum *= e }
end

##my_each
my_each_result = ["hey", "hi"].my_each { |n| print n + "! " }
print my_each_result
print "\n"
##my_each_with_index
[1, 1, 2, 3, 5, 8, 13].my_each_with_index { |i, num| print num ** i; print "\t" }
print "\n"
##my_select
print [1, 6, 9, 1, 2, 4, 9, 11, 15, 17, 22, 0].my_select { |n| n < 7 }
print "\n"
##my_all
numbers = [1, 2, 3, 4, 5, 6, 7]
puts numbers.my_all? { |n| n < 8 }
puts numbers.my_all? { |n| n > 2 }
##my_any
puts numbers.my_any? { |n| n > 6 }
puts numbers.my_any? { |n| n > 7 }
##my_none?
puts numbers.my_none? { |n| n > 7 }
puts numbers.my_none? { |n| n < 5 }
##my_count
puts numbers.count
puts numbers.count { |n| n.even? }
puts "\n"
##my_map
print numbers.my_map { |n| n ** 2 }
print "\n"
second_power = Proc.new { |sum, n| n ** 2 }
print [1, 2, 3, 4].my_map(&second_power)
print "\n"