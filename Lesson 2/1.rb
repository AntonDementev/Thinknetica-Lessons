#!/usr/bin/env ruby

months = {  
  January: 31,
  February: 28,
  March: 31,
  April: 30,
  May: 31,
  June: 30,
  July: 31,
  August: 31,
  September: 30,
  October: 31,
  November: 30,
  December: 31
}

puts "Месяцы в которых 30 дней:"
months.each do |month, days|
  puts month.to_s if days == 30
end
