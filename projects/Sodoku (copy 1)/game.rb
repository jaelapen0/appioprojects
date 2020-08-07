require_relative "./board.rb"

class Game
    def initialize(filename)
        @board = Board.new(filename)
    end

    def play
        until @board.solved?
            @board.render

            pos = self.get_pos
            value = self.get_value
            @board.update_tile(pos, value)

        end
        @board.render
        puts "puzzled solved!"
        return true
    end 
    
    def get_pos
        puts "Enter two numbers with space in between"
        pos = gets.chomp.split(" ").map! {|el| el.to_i}
        
        if pos.length == 2 &&  pos.all? {|el| el < 9 && el >0 } 
            return pos
        else
            puts "wrong pos format"
            self.get_pos
        end
    end
    
    def get_value
        puts "Enter a value"
        value = gets.chomp.to_i

        if value >0 && value <9
            return value
        else
            puts "wrong value format"
            self.get_value
        end
    end

end