def fundsByRetirement(age)
    half = age/2
    remaining_working_years = 65 - half
    
      ((half)**2) * remaining_working_years
end


p fundsByRetirement(30)


