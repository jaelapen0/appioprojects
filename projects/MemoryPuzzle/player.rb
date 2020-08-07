class HumanPlayer
    attr_reader :name
    def initialize(name)
        @name = name
    end

    def get_input(matched, revealed, hiddenpositions)
        puts "enter 2 numbers with a space between"
        input = gets.chomp.split(" ")
        guess = input.map! {|el| el.to_i}
        return guess
    end
end