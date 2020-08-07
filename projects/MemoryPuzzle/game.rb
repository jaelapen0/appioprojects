require_relative "./board.rb"
require_relative "./player.rb"
require_relative "./aiplayer.rb"

class Game
    def initialize(name, ainame)
        @board = Board.new
        @previous_guess = nil
        @values = []
        @attempts = 0
        @players = []
        @players << HumanPlayer.new(name)
        @players << AIPlayer.new(ainame)
        @current_player = @players[0]
        @board.populate
        @known_cards = Hash.new { |h, k| h[k] = [] }
        @matched_cards = []
        @firsturn = true
        @score = Hash.new(0)
        @players.each do |player|
            @score[player.name]= 0
        end
    end

    def get_score
        @score.each do |player, points|
            puts "Name:#{player}  Score:#{points}"
        end
    end

    def play_game
        until @board.won? 
            system("clear")
            puts "Attempts #{@attempts}"
            get_score
            hiddenPos = @board.get_hiddenpos
            puts "hidden pos"
            print hiddenPos
            puts
            @board.render
            puts "#{@current_player.name}'s turn:"
            guess = self.guess(@matched_cards, @known_cards, hiddenPos)

            self.make_guess(guess)
            if @firstTurn == false
                @players.rotate!
                @current_player = @players[0]
                @firstTurn = true
                @previous_guess = nil
            else
                @firstTurn = false
            end
        end
        sorted = @score.sort_by {|player,score| value}
        puts "#{sorted[0][0]} has won!"
    end

    def guess(match, known, hidden)
        guess =  @current_player.get_input(match, known, hidden)
        if inbounds?(guess)
            return guess
        elsif inbounds?(guess)== false
            puts "incorrect boundaries"
            self.guess(match, known, hidden)
        elsif already_revealed(guess) == true
            puts "position already revealed"
            self.guess(match, known, hidden)
        end
    end

    def already_revealed(guess)
        if @board[guess] =~ /A-Z/
            return true
        else
            return false
        end
    end

    def inbounds?(pos)
        x, y = pos
        if x > @board.size-1 || y > @board.size-1
            return false
        end
        return true
    end

    def make_guess(guess)
        g = @board.reveal(guess)
        puts "#{g} #{guess}   revealedddd"
        receive_revealed_card(g, guess)
        @values <<g
        sleep(4)
        if @previous_guess == nil
            @previous_guess = guess
        
        else
            if  @values[0] != @values[1]
                system("clear")
                puts "Attempts #{@attempts}"
                @board.render
                puts "No Match"
                sleep(4)
                x, y = @previous_guess
                @board.hide([x,y])
                a, i = guess
                @board.hide([a,i])
            else
                self.receive_match(guess, @previous_guess)
                system("clear")
                puts "Attempts #{@attempts}"
                @board.render
                puts "It's a match!"
                @score[@current_player.name] += 1
                sleep(2)
            end
           # @previous_guess = nil
            @values = []
            @attempts += 1
        end
    end
    
    def receive_revealed_card(g, guess)
        @known_cards[g] << guess
    end

    def receive_match(pos1, pos2)
        @matched_cards << [pos1, pos2]
    end

end