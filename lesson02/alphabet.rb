alphabet = ("a".."z").to_a
vowels = ["a","e","i","o","u"]
index = Hash.new(0) 

alphabet.each_with_index do |letter, num|
  if vowels.include?(letter)
    index[letter] = num + 1
  end
end
print index
