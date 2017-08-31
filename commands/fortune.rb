module Aichan
    #Give a fortune (calls fortune and sends the result)
    Aichan::BOT.command :fortune, description: 'fortuneteller', usage: "#{Aichan::BOT.prefix}fortune" do |event|
        event << event.user.mention
        event << '```'
        event << `fortune`
        event << '```'
    end

    #See :fortune
    Aichan::BOT.command :fortuna, help_available: false, description: 'fortuneteller', usage: "#{Aichan::BOT.prefix}fortune" do |event, *args|
        Aichan::BOT.execute_command(:fortune, event, args)
    end
end
