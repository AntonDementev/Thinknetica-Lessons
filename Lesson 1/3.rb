#!/usr/bin/env ruby
abc = Array.new 

puts "Введите длину первой стороны треугольника:"
abc[0] = gets.chomp.to_f

puts "Введите длину второй стороны треугольника:"
abc[1] = gets.chomp.to_f

puts "Введите длину третьей стороны треугольника:"
abc[2] = gets.chomp.to_f

if abc[0] == abc[1] && abc[1] == abc[2]
	puts "Треугольник равносторонний"
else 
	if abc[0] == abc[1] || abc[1] == abc[2] || abc[0] == abc[2]
		puts "Треугольник равнобедренный"
	end
	abc.sort!
	if abc[0]*abc[0]+abc[1]*abc[1] == abc[2]*abc[2]
		puts "Треугольник прямоугольный"
	end
end
