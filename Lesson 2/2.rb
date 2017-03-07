#!/usr/bin/env ruby

array = (2..20).to_a
array.map! {|x| x * 5}

puts array
