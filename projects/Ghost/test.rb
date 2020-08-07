require 'set'
    words = File.readlines("dictionary.txt")
    words.map! do  |word|
        word = word.chomp#word[0..-2]
    end
    dictionary = words.to_set
    p dictionary.include?('ant')