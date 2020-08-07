require_relative 'board'

class HumanPlayer
    attr_accessor :mark
    def initialize(mark)
        @mark = mark
    end 

    def get_position
        print "Enter position as 2 numbers with a space in between"
        input = gets.chomp.split(" ")
        newArr = []
        alpha = ("a".."z").to_a

        input.each do |char|
            if alpha.include?(char) || alpha.include?(char[0])
                raise "No letters, only numbers"
            else 
                newArr << char.to_i
            end
        end
        raise "Need 2 numbers" if newArr.length != 2 
        #puts @mark_value
        return newArr
    end

    

end