#!/usr/bin/env ruby

array = [1, 1]

while (new = array[-1]+array[-2]) < 100 do
  array << new
end

puts array
