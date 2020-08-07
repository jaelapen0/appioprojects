require_relative 'board'

class ComputerPlayer
    attr_accessor :mark
    def initialize(mark)
        @mark = mark
    end 

    def get_position(legal_positions)
        rand = legal_positions.sample
        puts "selected #{rand}"
        return rand
    end

    

end