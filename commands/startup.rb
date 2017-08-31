module Aichan
    require_relative '../helpers/startup'

    #Get a randomly generated tech startup idea (they all follow the same format)
    Aichan::BOT.command :startup, description: 'The next big thing', usage: "#{Aichan::BOT.prefix}startup" do |event|
        #Send typing because great ideas take time
        event.channel.start_typing
        event.respond(generate_idea)
    end
    
    #See :startup
    Aichan::BOT.command :idea, help_available: false, description: 'The next big thing', usage: "#{Aichan::BOT.prefix}startup" do |event, *args|
        Aichan::BOT.execute_command(:startup, event, args)
    end

end
