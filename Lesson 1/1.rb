#!/usr/bin/env ruby
puts "Введите своё имя:"
name = gets.chomp
puts "Введите свой рост в сантиметрах:"
height = gets.chomp.to_f

ideal_weight = height - 110

if ideal_weight < 0
	puts "#{name}, ваш вес уже оптимальный"
else
	puts "#{name}, ваш идеальный вес равен #{ideal_weight} кг."
end
