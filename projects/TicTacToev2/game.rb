require_relative 'board'
require_relative 'human_player'

class Game
    attr_reader :players, :current_player
    def initialize(n, *marks)
        @players = []

        marks.each do |mark|
            @players<< HumanPlayer.new(mark)
        end

        @board = Board.new(n)
        @current_player = @players[0]
    end

    def switch_turn
        @current_player = @players.rotate!.first
    end

    def play
        until @board.empty_positions? == false
            @board.printer
            pos = @current_player.get_position
            mark = @current_player.mark
            @board.place_mark(pos, mark)
            if @board.win?(mark)
                puts "#{@current_player.mark} has won the game"

                return @board.printer
                
            end
            if @board.empty_positions? == false && @board.win?(mark) == false
                @board.printer
                return "DRAW"
            end
            self.switch_turn
        end
    end
end