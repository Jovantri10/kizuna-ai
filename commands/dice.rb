module Aichan
    #Roll virtual dice
    Aichan::BOT.command :dice, description: 'Roll for seduction', usage: "#{Aichan::BOT.prefix}dice [sides] or #{Aichan::BOT.prefix}dice [dice d sides] (ex: #{Aichan::BOT.prefix}dice 2d6 for 2 6-sided dice or #{Aichan::BOT.prefix}dice 6 for one 6-sided die)" do |event, *args|
        #Remove spaces between words
        roll = args.join('').downcase
        #If they didn't provide a number of sides or dice, roll one d6
        if roll == ''
            event.respond("You rolled 1d6 and got #{(rand(6)) + 1}")
        #If they gave a number of sides and a number of dice, roll that many dice with that
        #many sides
        elsif roll.include?('d')
            #Split on 'd' to separate number of rolls from number of sides
            roll_list = roll.split('d')
            #Numbers are easier to work with as integers than as strings
            rolls = roll_list[0].to_i
            sides = roll_list[1].to_i
            #If, for some reason, they specified 0 rolls, roll 0 dice
            if rolls == 0
                event.respond("No dice")
                return
            end
            #Roll the specified dice the specified number of times and give the user the 
            #results
            event << "Rolling #{rolls}d#{sides} for #{event.user.mention}"
            event << "```"
            results = ""
            for i in 1..rolls
                results += "#{(rand(sides)) + 1}, "
            end
            event << results[0..-3]
            event << "```"
        #If they specified type of dice but not number, roll one of that kind
        else
            event.respond("You rolled a #{(rand(roll.to_i)) + 1}")
        end
        nil
    end

    #See :dice
    Aichan::BOT.command [:roll, :rolls], help_available: false, description: 'Roll for seduction', usage: "#{Aichan::BOT.prefix}dice [sides] or #{Aichan::BOT.prefix}dice [dice d sides] (ex: #{Aichan::BOT.prefix}dice 2d6 for 2 6-sided dice or #{Aichan::BOT.prefix}dice 6 for one 6-sided die)" do |event, *args|
        Aichan::BOT.execute_command(:dice, event, args)
    end
end
