alphabet = ("a".."z").to_a
vowels = ["a","e","i","o","u"]
vow_hash = {} 

alphabet.each_with_index do |letter, num|
  if vowels.include?(letter)
    vow_hash[letter] = num + 1
  end
end
print vow_hash
