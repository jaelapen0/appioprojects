require_relative "./item.rb"

class List

    attr_accessor :label
    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description="")
        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, description)
           # @items << newItem
            return true
        else
            return false
        end
    end

    def size
        return @items.length
    end

    def valid_index?(index)
        return false if index < 0 || index > @items.length-1
        return true
    end

    def swap(idx1, idx2)
        if !valid_index?(idx1) || !valid_index?(idx2)
            return false
        else
            @items[idx1], @items[idx2] = @items[idx2], @items[idx1]
            return true
        end
    end

    def [] (index)
        if !valid_index?(index)
            return nil
        else
            return @items[index]
        end
    end

    def priority
        return @items[0]
    end

    def print
        puts "____________________________"  
        puts self.label.upcase.center(20)
       # puts "___________________________"
        puts "Index | Item      |Deadline   |Done?]"
        #puts "___________________________"
          indices = []
          titles = []
          deadlines = []


         @items.each_with_index do |listItem, i|
            indices << "#{i}     |#{listItem.title.ljust(10)} |#{listItem.deadline.ljust(10)}| #{listItem.done} "
            #indices << ""

          end 

          puts indices
    end

    def print_full_index(index)
        return if !valid_index?(index)
        puts "--------------------------------------"
        puts "#{self[index].title}              #{self[index].deadline} "
        puts "#{self[index].description}     #{self[index].done} "  
        puts "--------------------------------------"
       # return true
    end

    def print_priority
        puts "--------------------------------------"
        puts "#{self[0].title}              #{self[0].deadline} "
        puts "#{self[0].description}        #{self[0].done}"  
        puts "--------------------------------------"
    end

    def up(index, amount)
        if !valid_index?(index)
            return false
        end
        until amount == 0 || index ==0
            swap(index, index-1)
            index = index-1
            amount -= 1
        end
        return true
    end

    def down(index, amount)
        if !valid_index?(index)
            raise "invalid index"
        end
        until amount == 0 || index == @items.length
            swap(index, index+1)
            index += 1
            amount -= 1
        end
        return true
    end

    def sort_by_date!(&prc)
        @items.sort_by! {|item| item.deadline }
    end

    def toggle(index)
        @items[index].toggle(index)
    end

    def remove_item(index)
        @items.delete_at(index)
    end

    def purge
        @items.each_with_index do |item, i|
            if item.done == true
                remove_item(i)
            end
        end
    end
end
