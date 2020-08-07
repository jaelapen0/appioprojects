class Board

    attr_accessor :grid
    def initialize(n)
        @grid = Array.new(n) {Array.new(n, "_")}

    end

    def [](position)
        row,col = position
        @grid[row][col] #= position

    end

    def[]= (position, val)
        row,col = position
        @grid [row][col]= val
    end

=begin def valid?(position)
        posx  = position[0]
        posy = position[1]
        @grid[posx,posy]
    end 
=end
    def valid?(position)
        row, col = position
        position.all? {|i| i >= 0 && i< @grid.length}
    
    end

    def empty?(position)
        row,col = position
        self[position] == '_'
       
    end

    def place_mark(position, mark)
        if !(valid?(position)) || !(empty?(position))
            raise "Position is not valid or full"
        else
            self[position] = mark
        end

    end

    def printer
        (0...self.grid.length).each do |idx|
            print self.grid[idx] 
            print "\n"
        end 
        return "^GRID:)^"
    end

    def win_row?(mark)
        self.grid.each do |row|
            count = 0
            row.each do |ele|
                if ele == row[0] && ele == mark #!= '_'
                    count+= 1
                    if count ==row.length
                        return true
                    end
                end
            end
        end
        return false
    end
    
    def win_col?(mark)
        self.grid.transpose.each do |row|
            count = 0
            row.each do |ele|             
                if ele == row[0] && ele == mark #!= '_'
                    count+= 1
                    if count ==row.length
                        return true
                    end
                else
                end
            end
        end
        return false
    end

    def win_diagonal?(mark)
        normal = self.grid
        backwards = self.grid.reverse
        if check_diagonal(normal, mark) || check_diagonal(backwards, mark)
            return true
        else
            return false
        end
    end

    def check_diagonal(board, mark)
        count = 0
        board.each_with_index do |row, i|
            if row[i] == mark
                count += 1
                if count == row.length 
                    return true
                end
            end
        end
        return false
    end

    def win?(mark)
        if win_col?(mark) || win_row?(mark) || win_diagonal?(mark)
            return true
        else
            return false
        end
    end

    def empty_positions?
        self.grid.each do |row|
            row.each do |ele|
                if ele == "_"
                    return true
                end
            end
        end
        return false
    end

end