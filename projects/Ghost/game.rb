require 'set'
require_relative "player.rb"
require_relative "ai_player.rb"
class Game
    attr_reader :players, :current_player, :record, :fragment, :dictionary
    def initialize(ai, *players)
        @players = []
        players.each do |player|
            @players << Player.new(player)
        end
        @players << Aiplayer.new(ai)
        words = File.readlines("dictionary.txt")
        words.map! do |word|
            word = word.chomp
        end
        @dictionary = words.to_set
        @fragment = ""
        
        @current_player = @players[0]
        @losses = Hash.new(0)
        @record = Hash.new("")
    end
    
    def play_game
        until @record.has_value?("GHOST") && @players.length == 1
            self.play_round
            @players.each do |player|
                if @record[player.name] == "GHOST"
                    puts "#{player.name} has lost"
                @players.delete(player)
                end
            end
        end
        puts "#{@players[0].name} is the winner"

        
    end

    def play_round
        until hasWord?
            puts "#{@current_player.name}'s turn"
            if take_turn(@current_player)
                puts "FRAGMENT: #{@fragment}"
                #puts "playerlist #{@players.name}"
                
            end
            self.next_player!
        end
        @losses[@previous_player.name]+= 1
        puts "LOSSES"
        puts @losses

        puts "RECORD"
        self.record
        puts @record
        @fragment = ""
        self.next_player!
       # puts "#{@fragment}"
       # puts "#{@current_player}"
    end
    def current_player
       @current_player = @players[0]
    end

    def previous_player
        idx = @players.index(@current_player)
        @previous_player = @players[idx-1]# @players[-1]
    end

    def next_player!
        # @players = @players.rotate
        @players.rotate!
        @current_player = @players[0]
    end

    def take_turn(player)
        input = player.guess(@fragment)
        if valid_play?(input) == false
            #puts "illegal play"
            player.alert_invalid_guess
            input = ""
            take_turn(player)
        end
        @fragment += input
       
    end

    def hasWord?
         (0...@fragment.length).each do |idx1|
            (idx1+2...@fragment.length).each do |idx2|
                if @dictionary.include?(@fragment[idx1..idx2])
                    puts "#{self.previous_player.name} loses due to #{@current_player.name}"
                    return true
                end
            end
        end
        return false
    end

    def valid_play?(string)
        alpha = ("a".."z").to_a
        string.each_char do |char|
            if alpha.include?(char) == false
                return false
            end
        end
        return true
    end

    def losses
        @losses
    end

    def record
        string = "GHOST"
        @players.each do |player|
            if @losses[player.name] != nil
                count = @losses[player.name]

                @record[player.name] = string[0...count]
            else
                @record[player.name]= ""
            end
        end
       # p @record
    end


end


a = Game.new("robit", "Jeff", "Moses", "Jae")
a.play_game
#a.play_round