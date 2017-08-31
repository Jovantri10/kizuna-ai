module Aichan
    #Set the bot's "playing" status
    Aichan::BOT.command :play, description: 'Make Ai-chan play a game', usage: "#{Aichan::BOT.prefix}play <game name>" do |event, *args|
        #If nothing was given, use a fallback
        if args.length == 0
            Aichan::BOT.game=CONFIG['default_game']
            break
        end
        Aichan::BOT.game=(args.join(' '))
    end
end
