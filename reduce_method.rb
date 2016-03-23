def reduce(array, starting_value= 0)
  counter = 0
  acc = starting_value

  loop do
    break if counter == array.size
    acc = yield(acc, array[counter])
    counter += 1
  end
  
  acc
end

array = [1,2,3,4,5]

p reduce(array) { |acc, num| acc + num }
p reduce(array, 10) { |acc, num| acc + num }
p reduce(array) { |acc, num| acc + num if num.odd? }