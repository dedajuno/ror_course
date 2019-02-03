=begin
6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара. На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

cart = Hash.new
total_sum = Hash.new

#puts "Input name of goods: "
#goods = gets.chomp

#puts "Input price of goods: "
#price = gets.to_i.chomp

#puts "Input quantity of goods: "
#quantity = gets.to_f.chomp
#puts "Press Enter to continue or Stop to quit and see your cart. "
#command = gets.chomp

#case shopping

#when "stop"
loop do
  puts "Input name of goods: "
  goods = gets.chomp
  break if goods == "stop"
#  if cart[goods.to_s].nil?
    puts "Input price of goods: "
    price = gets.to_i
#   basket[goods.to_s] = price.to_i
    puts "Input quantity of goods: "
    quantity = gets.to_f
    cart[goods.to_s] = { price: price, quantity: quantity }
    subtotal = price * quantity
    puts "SubTotal for #{goods} is #{subtotal}\n"
    puts ""
    puts ""
    total_sum[goods.to_sym] = subtotal.to_f 
end
puts cart
    puts ""
puts total_sum
    puts ""
total = 0
total_sum.each_value { |x| total += x }
puts "Your total sum is #{total}"
