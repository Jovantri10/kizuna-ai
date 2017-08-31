module Aichan
    #Get url for server emoji
    Aichan::BOT.command :bigemoji, description: 'Make emoji big', usage: "#{Aichan::BOT.prefix}bigemoji <emoji>", min_args: 0, max_args: 1 do |event, emoji|
        if emoji
            #The bot gets server emoji as <:Name:ID>, so see if we get something like that
            if emoji.match /<:[[[:alnum:]]_]+:[[:digit:]]+>/
                splitmoji = emoji.split ':'
                event.respond "https://cdn.discordapp.com/emojis/#{splitmoji[splitmoji.length - 1].gsub('>', '')}.png"
            else
                event.respond "Please give me a server emoji. I don't care what server"
            end
        else
            event.respond("I'm not sure what you want from me. Please give me an emoji to biggify")
        end
    end

    #See :bigemoji
    Aichan::BOT.command :bigmoji, help_available: false, description: 'Biggify server emoji', usage: "#{Aichan::BOT.prefix}bigemoji" do |event, *args|
        Aichan::BOT.execute_command :bigemoji, event, args
    end
end
