module Aichan
    require_relative '../helpers/dice.rb'
    #Roll virtual dice
    Aichan::BOT.command :dice, description: 'Roll for seduction', usage: "#{Aichan::BOT.prefix}dice [sides] or #{Aichan::BOT.prefix}dice [dice d sides] (ex: #{Aichan::BOT.prefix}dice 2d6 for 2 6-sided dice or #{Aichan::BOT.prefix}dice 6 for one 6-sided die)" do |event, *args|
        #Remove spaces between words and roll the dice
        results = roll(args.join('').downcase)
        #If no dice were rolled, say so
        if results['rolls'] == 0
            event.respond 'No dice'
        #If only one die was rolled, no need to make a list
        elsif results['rolls'] == 1
            event.respond "You rolled 1d#{results['sides']} and got #{results['results'][0]}"
        #If multiple dice were rolled, list the results
        #TODO: add a check to see if we're hitting the character limit
        else
            event << "Rolling #{results['rolls']}d#{results['sides']} for #{event.user.mention}"
            event << '```'
            dicerolls = ''
            for result in results['results']
                dicerolls += "#{result}, "
            end
            event << dicerolls[0..-3]
            event << '```'
        end
        nil
    end

    #See :dice
    Aichan::BOT.command [:roll, :rolls], help_available: false, description: 'Roll for seduction', usage: "#{Aichan::BOT.prefix}dice [sides] or #{Aichan::BOT.prefix}dice [dice d sides] (ex: #{Aichan::BOT.prefix}dice 2d6 for 2 6-sided dice or #{Aichan::BOT.prefix}dice 6 for one 6-sided die)" do |event, *args|
        Aichan::BOT.execute_command(:dice, event, args)
    end
end
