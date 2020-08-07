require_relative "./tile.rb"
require "deep_clone"

class Board
    def initialize(filename)
        @grid = Board.from_file(filename)
    end


    def self.from_file (filename)
        arr= []
        f = File.open(filename)
        
        f.each_line do |line|
            tempArr = []
            line.chomp.each_char do |el|
                tempArr << Tile.new(el.to_i)
            end
            arr << tempArr 
        end

        return arr
    end

    def render
        @grid.each do |subarray|
            subarray.each do |tile|
                print "#{tile.to_s} "
            end
            puts
        end

        return
    end
    
    def update_tile(pos, value)
        x, y = pos
        tile = @grid[x][y]
        if tile.added == false
             tile.value = value
             return true
        end
        return false

    end

    def solved?
        if rows? && columns? && threes?
            return true
        else
            return false
        end
    end

    def rows?
        @grid.each do |row|
            rowsum = 0
            row.each do |tile|
                rowsum += tile.value
            end
            return false if rowsum != 45
        end
        return true
    end

    def columns?
        @grid.transpose.each do |row|
            rowsum = 0
            row.each do |tile|
                rowsum += tile.value
            end
            return false if rowsum != 45
        end
        return true
    end

    def threes?
        a,b,c = @grid.each_slice(3).to_a
        if splitter(a) && splitter(b) && splitter(c)
            return true
        else
            return false
        end
    end

    def splitter(nineby3)
        pt1 = []
        pt2 = []
        pt3 = []
        nineby3.each do |sub|
            sub.each_with_index do |tile, i|
                if i <= 2
                    pt1 << tile.value
                elsif i <6 && i >2
                    pt2 << tile.value
                else
                    pt3 << tile.value
                end
            end
        end

        return false if pt1.flatten.sum != 45
        return false if pt2.flatten.sum != 45
        return false if pt3.flatten.sum != 45

        return true
    end



end