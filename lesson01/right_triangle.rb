puts "Input side a:"
a = gets.to_f
puts "Input side b:"
b = gets.to_f
puts "Input side c:"
c = gets.to_f

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
