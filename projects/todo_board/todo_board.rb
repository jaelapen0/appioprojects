require_relative "./list.rb"

class TodoBoard
    def initialize#(label)
        @lists = {}
        #@list = List.new(label)
    end

    def get_command
        puts ""
        puts "mklist <listlabel>"
        puts "ls"
        puts "showall"
        puts "Input the following information with spaces"
        puts  "mktodo <listlabel> <title> <deadline> <optional description>"
        puts "up <listlabel> <index> <optional amount>"
        puts "down <listlabel> <index> <optional amount>"
        puts "swap <listlabel> <index_1> <index_2>"
        puts "sort <listlabel>"
        puts "priority <listlabel>"
        puts "toggle <listlabel> <index>"
        puts "print <optional index>"
        puts "rm <listlabel> <index>"
        puts "purge <listlabel>"
        puts  "quit"

        cmd, *args = gets.chomp.split(" ")

        case cmd
        when 'mklist'
            label = args[0]
            @lists[label] = List.new(label)
        when 'ls'
            puts @lists.keys
        when 'showall'
            print @lists
        when 'mktodo'
            listname = args.shift
            @lists[listname].add_item(*args)
        when 'quit'
            return false
        when 'up'
            listname = args.shift
            idx1 = args[0].to_i
            idx2 = args[1].to_i
            @lists[listname].up(idx1, idx2)
        when 'down'
            listname = args.shift
            idx1 = args[0].to_i
            idx2 = args[1].to_i
            @lists[listname].down(idx1, idx2)
        when 'swap'
            listname = args.shift
            idx1 = args[0].to_i
            idx2 = args[1].to_i
            @lists[listname].swap(idx1, idx2)
        when 'sort'
            listname = args.shift
            puts @lists[listname].sort_by_date!#(&prc)
        when 'priority'
            listname = args.shift
            @lists[listname].print_priority
        when 'toggle'
            listname = args.shift
            idx = args[0].to_i
            @lists[listname].toggle(idx)
        when 'rm'
            listname = args.shift
            idx = args[0].to_i
            @lists[listname].remove_item(idx)
            #@list.remove_item(idx)
        when 'purge'
            listname = args.shift
            @lists[listname].purge
        when 'print'
            listname = args.shift
            count = 0
            args.each do |arg|
                count +=1 
            end
            raise "incorrect"  if count > 1
            if count < 1
                @lists[listname].print
            else
               @lists[listname].print_full_index(*args[0].to_i)
            end
        else
             print "Sorry, that command is not recognized."
        end
        puts ""
        true

    end

    def run
        until self.get_command == false
            self.get_command
            
        end
    end

end

a = TodoBoard.new
a.run

