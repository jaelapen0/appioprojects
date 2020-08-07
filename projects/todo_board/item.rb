class Item
    

    def self.valid_date?(date)
        dateParts = date.split("-")
        return false if dateParts[0].length != 4
        return false if dateParts.length != 3
        return false if dateParts[1].to_i < 1 || dateParts[1].to_i > 12
        return false if dateParts[2].to_i < 1 || dateParts[2].to_i > 31
                
        return true
    end
    attr_accessor :title, :deadline, :description
    attr_reader :done

    def initialize(title, deadline, description="")
        @title = title
        @deadline = deadline
        @description = description
        @done = false

       # if !Item.valid_date?(deadline)# == false
        #    raise "Invalid date" 
      #  end
    end

    def toggle(index)
        if @done == false
            @done = true
        else
            @done = false
        end
    end
end

#a = Item.new('Fix checkout page','10-25-2019', 'The font is too small.') 