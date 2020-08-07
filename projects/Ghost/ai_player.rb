#require_relative 'game.rb'

class Aiplayer
    attr_reader :name
    def initialize(name)
        @name = name
         words = File.readlines("dictionary.txt")
        words.map! do |word|
            word = word.chomp
        end
        @dictionary = words.to_set
    end

    def guess(fragment)
        alpha = ("a".."z").to_a
        testWord = fragment
        alpha.each do |char|
            word = testWord + char
            if check_guess(word)
                puts "checked word"
                return char
            end
        end
        puts "sample"
        return alpha.sample
    end

    def check_guess(word)
        (0...word.length).each do |idx1|
            (idx1+2...word.length).each do |idx2|
                if @dictionary.include?(word[idx1..idx2])
                    return true
                end
            end
        end
        return false
    end



end

a = Aiplayer.new("robit")