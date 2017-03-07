#!/usr/bin/env ruby
all_products={}
loop do
  puts "Введите название товара или ключевое слово \"стоп\" для завершения:"
  title = gets.chomp
  break if title == "стоп"
  
  if all_products[title].nil?
    puts "Введите цену данного товара:"
    price = gets.chomp.to_f
    puts "Введите количество данного товара:"
    amount = gets.chomp.to_f
    all_products[title] = {
      price: price,
      amount: amount
    }
   else
     #если такой товар уже есть, увеличиваем количество (или не увеличиваем, если пользователь введёт 0)
     puts "Данный товар уже имеется в количестве #{all_products[title][:amount]} шт., по цене #{all_products[title][:price]} руб."
     puts "Введите количество дополнительных единиц товара:"
     amount = gets.chomp.to_i
     all_products[title][:amount] += amount
   end
end

all_products_price = 0

all_products.each do |product, incuded_hash|
  current_products_price = incuded_hash[:amount] * incuded_hash[:price]
  all_products_price += current_products_price
  puts product +": #{incuded_hash[:amount]} шт. по цене #{incuded_hash[:price]} руб. (Итого: #{current_products_price} руб.)"
end

puts "Общая сумма: #{all_products_price} руб."
