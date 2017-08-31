module Aichan
    require_relative '../helpers/rate'
    #Determine the chances of something happening
    Aichan::BOT.command :odds, description: 'rate odds of something', usage: "#{Aichan::BOT.prefix}odds <thing to rate odds of>" do |event, *args|
        #If they didn't give something to get the odds of, ask what they want
        if args.length == 0
            event.respond('Odds of what?')
            return
        end
        #If they gave something, get the odds and give them the odds (see rate.c)
        argstring = args.join(' ')
        argstring = first_second(argstring)
        #Remove any single quotes (aka apostrophes) to keep people from closing the quotation marks
        event.respond("I'd put the odds #{argstring} at around #{`helpers/rate -o '#{argstring.gsub("'", '')}'`}%")
    end

    #See :odds
    Aichan::BOT.command [:chance, :chances, :probability], help_available: false, description: 'rate odds of something', usage: "#{Aichan::BOT.prefix}odds <thing to rate odds of>" do |event, *args|
        Aichan::BOT.execute_command(:odds, event, args)
    end
end
