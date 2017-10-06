module Aichan
    #Get url for server emoji
    Aichan::BOT.command :bigemoji, description: 'Make emoji big', usage: "#{Aichan::BOT.prefix}bigemoji <emoji>", min_args: 0, max_args: 1 do |event, emoji|
        retval = ''
        if emoji
            #The bot gets server emoji as <:Name:ID>, so see if we get something like that
            emoji.match /<:[[[:alnum:]]_]+:[[:digit:]]+>/ do |e|
                splitmoji = e.to_s.split ':'
                retval = "https://cdn.discordapp.com/emojis/#{splitmoji[splitmoji.length - 1].gsub('>', '')}.png"
            end
            retval = "Please give me a server emoji. I don't care what server" if retval == ''
        else
            retval = "I'm not sure what you want from me. Please give me an emoji to biggify"
        end
        event.respond retval
    end

    #See :bigemoji
    Aichan::BOT.command :bigmoji, help_available: false, description: 'Biggify server emoji', usage: "#{Aichan::BOT.prefix}bigemoji" do |event, *args|
        Aichan::BOT.execute_command :bigemoji, event, args
    end
end
