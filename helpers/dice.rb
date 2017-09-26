def roll(type)
    #Ready an array for the results
    results = []
    #Ready the map that will actually be returned (to give easy access to number of
    #  rolls and of sides
    retval = {}
    #If the rolls and number of sides aren't specified, just roll 1d6
    if type == ''
        #rolls.push(rand(6) + 1)
        retval['rolls'] = 1
        retval['sides'] = 6
    #If they specify number of rolls and number of sides, roll as specified
    elsif type.include?('d')
        rolls, sides = type.split('d')
        retval['rolls'] = rolls.to_i
        retval['sides'] = sides.to_i
    #If they only give one number, roll one die with that many sides
    else
        retval['rolls'] = 1
        retval['sides'] = type.to_i
    end
    #Actually roll the dice
    for i in 1..retval['rolls']
        results.push(rand(retval['sides']) + 1)
    end
    retval['results'] = results
    retval
end
