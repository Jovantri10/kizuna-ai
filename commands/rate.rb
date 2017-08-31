module Aichan
    require_relative '../helpers/rate'

    #Rate a file or statement (see rate.c)
    Aichan::BOT.command :rate, description: 'rate something', usage: "#{Aichan::BOT.prefix}rate <thing to rate>" do |event, *args|
        #If they didn't give anything to rate, ask what should be rated. If they gave an 
        #attachment, rate that file(name)
        if args.length == 0
            if event.message.attachments.length == 0
                event.respond('0/10. Give me something to rate')
                return
            else
                argstring = event.message.attachments[0].url
                #Remove any apostrophes to keep people from ending the string prematurely
                event.respond("I'd give that #{`helpers/rate -r '#{argstring.gsub("'", '')}'`}/10")
                return
            end
        end
        #If they gave some text to rate, rate it
        argstring = args.join(' ')
        argstring = first_second(argstring)
        if is_self?(argstring)
            event.respond("I'd give myself 10/10, of course!")
        else
            event.respond("I'd give #{argstring} #{`helpers/rate -r '#{argstring.gsub("'", '')}'`}/10")
        end
    end

    #See :rate
    Aichan::BOT.command :ratewaifu, help_available: false, description: 'rate something', usage: "#{Aichan::BOT.prefix}rate <thing to rate>" do |event, *args|
        Aichan::BOT.execute_command(:rate, event, args)
    end
end
