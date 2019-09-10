# frozen_string_literal: true

class Array
  # Extend the Array class to include a method named my_each that takes a
  # block, calls the block on every element of the array, and returns the
  # original array. Do not use Enumerable's each method.

  def my_each(&prc)
    i = 0
    while i < length
      el = self[i]
      prc.call(el)
      i += 1
    end
    self
  end

  def my_select(&prc)
    selected = []
    my_each { |el| selected << el if prc.call(el) }
    selected
  end

  def my_reject(&prc)
    selected = []
    my_each { |el| selected << el unless prc.call(el) }
    selected
  end

  def my_any?(&prc)
    my_each { |el| return true if prc.call(el) }
    false
  end

  def my_all?(&prc)
    my_each { |el| return false unless prc.call(el) }
    true
  end

  def my_flatten
    flattened = []
    my_each do |el|
      flattened += if el.is_a?(Array)
                     el.my_flatten
                   else
                     [el]
                   end
    end
    flattened
  end

  def my_zip(*arrays)
    zipped = []
    each_with_index do |el, i|
      zipped << [el]
      arrays.each do |array|
        zipped[i] << array[i]
      end
    end

    zipped
  end

  def my_rotate(magnitude = 1)
    rotated = Array.new(self)
    if magnitude.positive?
      magnitude.times do
        rotated.push(rotated.shift)
      end
    else
      magnitude.abs.times do
        rotated.unshift(rotated.pop)
      end
    end
    rotated
  end

  def my_join(separator = '')
    str = ''
    each_with_index do |el, i|
      str += el
      str += separator unless i == length - 1
    end
    str
  end

  def my_reverse
    reversed = []
    reverse_each do |el|
      reversed << el
    end
    reversed
  end

  def bubble_sort!(&prc)
    prc ||= proc { |a, b| a <=> b }

    sorted = false
    until sorted
      sorted = true
      (0...length - 1).each do |i|
        if prc.call(self[i], self[i + 1]) == 1
          sorted = false
          self[i], self[i + 1] = self[i + 1], self[i]
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    dup.bubble_sort!(&prc)
  end

  # def bubble_sort(&prc)
  #   sorted_array = dup
  #   prc ||= proc { |a, b| a <=> b }
  #   sorted = false
  #   until sorted
  #     sorted = true
  #     (0...sorted_array.length - 1).each do |i|
  #       if prc.call(sorted_array[i], sorted_array[i + 1]) == 1
  #         sorted = false
  #         sorted_array[i], sorted_array[i + 1] = sorted_array[i + 1], sorted_array[i]
  #       end
  #     end
  #   end
  #   sorted_array
  # end
end

# return_value = [1, 2, 3].my_each { |num| puts num * 2 }
# p return_value

# p [1, 2, 3, 4, 5, 6].my_select { |num| num.even? }

# p [1, 2, 3, 4, 5, 6].my_reject { |num| num.even? }

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false

# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# array_2 = ['this', %w[problem is], [%w[pretty tough], [[':)']]]]
# p array_2.my_flatten # => [ 'this', 'problem', 'is', 'pretty', 'tough', ':)' ]

# a = [4, 5, 6]
# b = [7, 8, 9]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1, 2], [8]) # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d) # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# a = %w[a b c d]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = %w[a b c d]
# p a.my_join         # => "abcd"
# p a.my_join('$')    # => "a$b$c$d"

# p %w[a b c].my_reverse #=> ["c", "b", "a"]
# p [1].my_reverse #=> [1]

# a = [1, 3, 4, 2]
# p a.bubble_sort { |a, b| a <=> b } #=> [1, 2, 3, 4]
# p a #=> [1, 3, 4, 2]
# p %w[a d b c].bubble_sort #=> ["a", "b", "c", "d"]
# p [1].bubble_sort #=> [1]
# p [].bubble_sort #=> []

# p a.bubble_sort! { |a, b| a <=> b } #=> [1, 2, 3, 4]
# p a #=> [1, 2, 3, 4]
# p %w[a d b c].bubble_sort! #=> ["a", "b", "c", "d"]
# p [1].bubble_sort! #=> [1]
# p [].bubble_sort! #=> []
