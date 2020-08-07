require_relative "./card.rb"
require "byebug"

class Board
    attr_reader :secondgrid, :card, :size#, :hiddenpositions
    def initialize(size=4)
        @size = size
        @rendergrid = Array.new(size){Array.new(size, " ")}
        @grid = Array.new(size){Array.new(size)} 
        @pairs = self.get_pairs * 2
        @card = Card.new("R")
        @hiddenpositions = []
    end

    def [] (pos)
        x, y= pos
       return  @rendergrid[x][y]
    end

    def get_pairs
        @count = @grid.flatten.length/2
        @alpha = ("A".."Z").to_a
        pairs = []
        until pairs.length == @count
            random = @alpha.sample
            pairs << random
            @alpha.delete(random)
        end
        return pairs
    end

    def populate
        #debugger
        counts = Hash.new(0)

        @secondgrid = []
        @grid.each do |array|
            temparr= []
            array.each do |ele|
                value = @pairs.sample
                temparr << Card.new(value)
                counts[value] += 1
                if counts[value] == 2
                    @pairs.delete(value)
                end 
            end
            @secondgrid << temparr
        end       
    end

    def render
        print " "
        (0...@size).each do |ele|
            print " #{ele}"
        end
        puts
        
        @secondgrid.each_with_index do |array, gidx|
            array.each_with_index do |card, aidx|
                if card.revealed == true
                    @rendergrid[gidx][aidx] = card.value
                else
                    @rendergrid[gidx][aidx] = " "
                   # @hiddenpositions << [gidx, aidx]
                end
            end
        end
        #puts "#{(0..@count/2)}"
        @rendergrid.each_with_index do |array, i|
            print "#{i}"
            array.each do |ele|
                print " #{ele}"
                #print array
            end
            puts
        end
        nil
    end

    def won?
        count = 0
        @rendergrid.each do |array|
            array.each do |ele|
                if ele != " "
                    count += 1
                end
            end
        end
        if count == @count * 2
            return true
        else
            return false
        end
    end

    def reveal(pos)
        x, y = pos
        @secondgrid[x][y].reveal#ed = true

        return @secondgrid[x][y].value
    end

    def hide(pos)
        x, y = pos
        @secondgrid[x][y].hide
        return nil
    end

    def get_hiddenpos
        @hiddenpositions = []
        @secondgrid.each_with_index do |array, gidx|
            array.each_with_index do |card, aidx|
                if card.revealed == true
                    #@rendergrid[gidx][aidx] = card.value
                else
                   # @rendergrid[gidx][aidx] = " "
                    @hiddenpositions << [gidx, aidx]
                end
            end
        end
    return @hiddenpositions
    end
end