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

  def my_map(&block)
    result = []
    self.my_each { |e| result << block.call(e) } if block_given?
    result.empty? ? self : result
  end

  def my_inject(initial = nil)
    result = (initial.nil? ? self.first : initial)
    elements_needed = (initial.nil? ? (1..self.size - 1) : (0..self.size - 1))

    elements_needed.to_a.each do |index|
      result = yield(result, self[index])
    end

    result
  end
end

def multiply_elements(elements)
  elements.my_inject(1) { |sum, e| sum *= e }
end