class AIPlayer
    attr_reader :name
    def initialize(name)
        @name = name
    end

    def get_move(fragment, dictionary)
        alpha = ("a".."z").to_a
        possibleLetters= []
        alpha.each do |letter|
            tempFrag = fragment + letter
            (0...tempFrag.length).each do |idx1|
                (idx1+2...tempFrag.length).each do |idx2|
                    if dictionary.include?(tempFrag[idx1..idx2])
                        possibleLetters << letter
                    end
                end
            end
        end

        if possibleLetters.length < 1
         a = alpha.sample
            print "  #{a}"
            puts
            return a
            
        else
            a = possibleLetters.sample
            print "  #{a}"
            puts
            return a
            
        end 

    end

end