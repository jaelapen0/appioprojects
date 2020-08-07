def iupcase(str)
    str.chars#.inject("") do |upcased_str, char|
        #upcased_str << char.upcase
    end#
end

p iupcase("hello")