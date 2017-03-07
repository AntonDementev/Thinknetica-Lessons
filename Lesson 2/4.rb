#!/usr/bin/env ruby

hash = Hash.new

letters = ("a".."z").to_a

for i in 1..26 do
 hash[letters[i-1]] = i
end

puts hash


