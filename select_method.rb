def select(array)
  counter = 0
  new_array = []
  loop do
    break if counter == array.size
    new_array << array[counter] if yield(array[counter])
    counter += 1
  end
  new_array
end

some_array = [1,2,3,4,5]

p select(some_array) { |num| num.odd? }
p select(some_array) { |num| puts num }
p select(some_array) { |num| num + 1 }