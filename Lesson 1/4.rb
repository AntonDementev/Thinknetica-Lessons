#!/usr/bin/env ruby
puts "Введите поочерёдно коэффициенты уравнения, приведённого к виду \"ах^2 + bx + c = 0\"."
puts "Ввод коэффициента a:"
a = gets.chomp.to_f
puts "Ввод коэффициента b:"
b = gets.chomp.to_f
puts "Ввод коэффициента c:"
c = gets.chomp.to_f

d = b*b - 4*a*c

if d < 0
  puts "Дискреминант равен #{d}; действительных корней нет"
elsif d == 0
  puts "Одно решение: x=#{-b/(2*a)}"
elsif d > 0
  puts "Два решения: x1=#{(-b-Math.sqrt(d))/(2*a)}, x2=#{(-b+Math.sqrt(d))/(2*a)}"
end
