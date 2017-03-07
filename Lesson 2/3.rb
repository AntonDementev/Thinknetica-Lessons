#!/usr/bin/env ruby

array = [1, 1]
index = 2
loop do
  new = array[index-1]+array[index-2]
  if new > 100
    break
  else
    array[index] = new
    index += 1
  end
end

puts array
