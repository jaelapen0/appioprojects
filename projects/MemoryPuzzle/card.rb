class Card
    attr_reader :value  
    def initialize(value)
        @value = value
        @revealed =false
    end

    def hide
        @revealed = false
    end

    def reveal
        @revealed = true
    end

    def revealed
        @revealed
    end
    def to_s
      #  if @revealed == true
       #     value.to_s : " "
        #end
        revealed ? value.to_s : " "
    end

    def ==(object)
         object.is_a?(self.class) && object.value == value
    end

end