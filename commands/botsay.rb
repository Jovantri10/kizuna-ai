module Aichan
    #Make the bot say dumb things
    Aichan::BOT.command :botsay, description: 'echo chamber', usage: "#{Aichan::BOT.prefix}botsay <thing to say>" do |event, *args|
        event.respond(args.join(' '))
    end
    
    #See :botsay
    Aichan::BOT.command :say, help_available: false do |event, *args|
        Aichan::BOT.execute_command(:botsay, event, args)
    end
end
