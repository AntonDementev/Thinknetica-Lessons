#!/usr/bin/env ruby

result_hash = {}


letters = ("a".."z").to_a
vowels = ["a", "e", "i", "o", "u", "y"]

vowels.each do |current_vowel|
  index = letters.index(current_vowel)
  result_hash[current_vowel] = index + 1
end

puts result_hash


