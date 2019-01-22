puts "Please input your name:"
name = gets.chomp

puts "Please input your height:"
height = gets.to_i

ideal_weight = height - 110

if ideal_weight < 0
  puts "#{name.capitalize}, your weight is optimal!"
else
  puts "#{name.capitalize}, your weight is above normal!"
end
