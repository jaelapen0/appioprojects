
def increaser(startNum, times)
    a= times
    while times > 0
        startNum = startNum * 1.0056
        times -= 1
    end
    puts "days :#{a}"
    return startNum
end


p increaser(1000, 715)

def rCursive_Increaser(startnum, amount)
    return startnum.to_i if amount == 716

    startnum = startnum * 1.0056 
    rCursive_Increaser(startnum, amount+1)
end

p rCursive_Increaser(1000, 1)


def fib (start1, start2, nth)
    return start2 if nth == 50
    arr = [1,1,2]

end