require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
    attr_reader :players, :current_player
    def initialize(n, hash)
        @players = []

        hash.each do |k,v|
            if v == false
                @players << HumanPlayer.new(k)
            else
                @players << ComputerPlayer.new(k)
            end
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
            positions = @board.legal_positions
            pos = @current_player.get_position(positions)
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