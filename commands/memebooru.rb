module Aichan
    #Get a meme from danbooru
    Aichan::BOT.command :memebooru, help_available: false, description: '$danbooru meme', usage: "#{Aichan::BOT.prefix}memebooru [tag]" do |event, *args|
        if Aichan::BOT.commands.include? :danbooru
            if args.length > 0
                Aichan::BOT.execute_command(:danbooru, event, "meme+#{args.join('_')}".split('_'))
            else
                Aichan::BOT.execute_command(:danbooru, event, ['meme'])
            end
        else
            event.respond 'Danbooru command is disabled, so no memes'
        end
    end
end
