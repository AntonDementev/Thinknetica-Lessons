#!/usr/bin/env ruby

puts "Введите год:"
year = gets.chomp.to_i
puts "Введите номер месяца:"
month = gets.chomp.to_i
puts "Введите число:"
day = gets.chomp.to_i


#         jan feb  mar arp may jun jul aug sep oct nov dec
months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
#Если год високостный, а февраль закончился, день будет прибавлен

day_result = 0

if month >= 3 && ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
  day_result += 1
end

day_result += day
month -= 1

while month > 0 do
  day_result += months[month-1]
  month -= 1
end

puts "Номер дня при отсчёте с начала года: #{day_result}"
