class AIPlayer
    attr_reader :name

    def initialize(name)
        @name = name
        @guessNo = 1
        @knownmatches= []
    end

    def get_input(matched, revealed, hiddenpositions)
        if @guessNo == 1
            @knownmatches = []
            puts "revealed matches: #{revealed}"
            sleep(2)
            revealed.each do |val,pos|
                if pos.uniq.length > 1 &&  hiddenpositions.include?(pos[0])  #!(matched.include?(pos.uniq[0]))
                    input = pos.uniq[0]
                    @knownmatches << pos.uniq[0]
                    @knownmatches << pos.uniq[1]
                    @guessNo += 1
                    return input
                end
            end
            #guess random known location
            puts "known matches Guess1  : #{@knownmatches}"
            
            input = hiddenpositions.sample
            @guessNo += 1
        else
            if @knownmatches.length == 2
                puts "known matches Guess 2: #{@knownmatches}"
                input = @knownmatches[1]
                @guessNo -=1
            else
                input = hiddenpositions.sample
                 @guessNo -=1
            end
        end
        return input
    end
end