puts "Input side a:"
a = gets.to_i
puts "Input side b:"
b = gets.to_i
puts "Input side c:"
c = gets.to_i

squared = a ** 2 + b ** 2 == c ** 2 || a ** 2 + c ** 2 == b ** 2 || b ** 2 + c ** 2 == a ** 2
isosceles = a == b || b == c || c == a
equal = a == b && a == c

if squared
  print "squared"
elsif equal
  print "equal"
elsif isosceles && squared
  print "isosceles & squared"
elsif isosceles
  print "iso"
end










#if (a ** 2 + b ** 2 == c ** 2 || a ** 2 + c ** 2 == b ** 2 || b ** 2 + c ** 2 == a ** 2) && a == b || b == c || c == a
# puts "Squared triangle!"
## if a == b || b == c || c == a
#   puts "Squared isosceles triangle!"
#else
#   puts "Squared triangle"
# end
#elsif a == b && a == c 
# puts "Equal triangle!"
#else 
# puts "Simple triangle"
#end

##find a hypothenuse
#if a > b && a > c
#  print "hyppothenuse = a"
#elsif b > a && b > c
#  print "hyppotenuse = b"
#else
#  print "hypothenuse = c"
#end
#
#
