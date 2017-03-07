#!/usr/bin/env ruby
allProducts=Hash.new
loop do
  puts "Введите название товара или ключевое слово \"стоп\" для завершения:"
  title = gets.chomp
  break if title == "стоп"
  
  if allProducts[title].nil?
    puts "Введите цену данного товара:"
    price = gets.chomp.to_f
    puts "Введите количество данного товара:"
    amount = gets.chomp.to_f
    allProducts[title] = {
      price: price,
      amount: amount
    }
   else
     #если такой товар уже есть, увеличиваем количество (или не увеличиваем, если пользователь введёт 0)
     puts "Данный товар уже имеется в количестве #{allProducts[title][:amount]} шт., по цене #{allProducts[title][:price]} руб."
     puts "Введите количество дополнительных единиц товара:"
     amount = gets.chomp.to_i
     allProducts[title][:amount] += amount
   end
end

allProductsPrice = 0

allProducts.each do |product, hash|
  currentProductsPrice = hash[:amount] * hash[:price]
  allProductsPrice += currentProductsPrice
  puts product +": #{hash[:amount]} шт. по цене #{hash[:price]} руб. (Итого: #{currentProductsPrice} руб.)"
end

puts "Общая сумма: #{allProductsPrice} руб."
