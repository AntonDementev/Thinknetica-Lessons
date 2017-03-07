#!/usr/bin/env ruby

array = []
current_element = 10

while current_element <= 100 do
  array << current_element
  current_element += 5
end

puts array
