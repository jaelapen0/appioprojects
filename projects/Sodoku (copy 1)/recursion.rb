def sum_to(n)
    return nil if n < 0
    return 1 if n == 1

    num = n
    num + sum_to(n-1)
end

def add_numbers(arr)
    return arr[0] if arr.length <= 1

    arr.pop +  add_numbers(arr)
    
end

def ice_cream_shop(list, flavor)
    return true if list[0] == flavor
    return false if list.length < 1

     ice_cream_shop(list[1..-1], flavor)

end

def reverse(string)
    return string if string.length <= 1

    string[-1] + reverse(string[0..-2])

end

def gamma_fnc(num)
    return nil if num == 0
    return num if num == 1
    (num-1)  * gamma_fnc(num-1)
end 
  p gamma_fnc(0)  # => returns nil
  p gamma_fnc(1)  # => returns 1
  p gamma_fnc(4)  # => returns 6
  p gamma_fnc(8)  # => returns 5040