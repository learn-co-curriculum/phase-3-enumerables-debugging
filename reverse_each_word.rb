require 'pry'
# Write your code here

def reverse_each_word(sentence)
  sentence_arr = sentence.split
  reversedArr = sentence_arr.map(&:reverse)
  reversedArr.join(" ")
  # sentence.split.map(&:reverse).join(" ")
end

binding.pry
0