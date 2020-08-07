
require_relative "./player.rb"
require_relative "./aiplayer.rb"
class Game
    attr_reader :fragment, :current_player, :previous_player

    def initialize(ai, *players)
        @players = []
        players.each do |player|
            @players << Player.new(player)
        end
        @players << AIPlayer.new(ai)
        @fragment  = ""
        @current_player = @players[0]
        @previous_player = @players[-1]
        @dic = []
        File.open("./dictionary.txt").each_line do |line|
            @dic <<line.chomp
        end
        @dic = @dic.to_set
        
        @losses = {}
        @players.each do |player|
            @losses[player.name] = 0
        end
        nil


    end

    def run
        until @players.length == 1
            self.play_round

            @players.each_with_index do |player, i|
                if @losses[player.name] ==5
                    puts "#{player.name} has Lost!!!!!"
                    @players.delete_at(i)
                end
            end
            self.next_player!
        end

        puts "#{@players[0].name} has won!"

            

    end

    def next_player!
        @players.rotate!
        @current_player = @players[0]
        @previous_player = @players[-1]
    end

    def take_turn(player)
            puts "CURRENT FRAGMENT  =>  #{@fragment}"
            puts "#{@current_player.name}"
            string = player.get_move(@fragment, @dic)
            if string.length > 1 
                puts "too many letters"
                take_turn(player)
            end
            if valid_play?(string)== false
                puts "invalid move"
                take_turn(player)
            end
            @fragment += string

    end

    def valid_play?(string)
        alpha = ("a".."z").to_a
        if alpha.include?(string)
            return true
        else
            return false
        end
    end

    def has_word
        (0...@fragment.length).each do |idx1|
            (idx1+2...@fragment.length).each do |idx2|
                if @dic.include?(@fragment[idx1..idx2])
                    #self.next_player!
                    puts "Winning word: #{@fragment[idx1..idx2]}"
                    return true
                end
            end
        end
        return false
    end

    def play_round
        take_turn(@current_player)
        if self.has_word == false
            self.next_player!
            self.play_round
        else
            puts "#{@current_player.name} has won the round"
            puts "#{@previous_player.name} has lost the round"
            
            @losses[previous_player.name] +=1 
            self.scoreBoard
            #piu
            @fragment = ""
            return true
        end
        
    end
    
    def scoreBoard
        letters = "GHOST"
                puts "------------------"
                puts "    SCOREBOARD    "
                puts "------------------"
                puts "Player   | Letters" 
                puts "------------------"
            @losses.each do |player, v|
                num = @losses[player]#.name]
                if v > 0
                    puts "#{player.ljust(9)} #{letters[0...v]}"
                    puts "------------------"
                else
                    puts "#{player.ljust(8)}"
                    puts "------------------"
                end
            end
                puts "------------------" 

    end

end