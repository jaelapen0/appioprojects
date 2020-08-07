class Player
    attr_reader :name
    def initialize(name)
        @name = name
    end

    def get_move(fragment, dictionary)
        puts "enter a letter"
        input = gets.chomp
       # if input.length != 1
            #self.get_move
        #end
        return input
    end
end