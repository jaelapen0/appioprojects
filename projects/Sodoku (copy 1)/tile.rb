require 'colorize'

class Tile

    attr_reader :added 
    attr_accessor :value
    def initialize(value)
        @value = value
        @added = value == 0? false : true
    end

    def color
        if @added == false
            return :blue
        else
            return :red
        end
    end

    def to_s
        #@value == 0 ? " " : @value.to_s.colorize(color)
        @value == 0 ? " " : @value.to_s.colorize(color)
    end

end