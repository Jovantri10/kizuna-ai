module Aichan
    require_relative '../helpers/play.rb'
    #Set the bot's "playing" status
    Aichan::BOT.command :play, description: 'Make Ai-chan play a game', usage: "#{Aichan::BOT.prefix}play <game name>" do |event, *args|
        #If nothing was given, use a fallback
        if args.length == 0
            #See if game should be number of servers
            playing = parse_special(CONFIG['default_game'], Aichan::BOT.servers.length)
            Aichan::BOT.game=playing
            break
        end
        Aichan::BOT.game=(args.join(' '))
    end
end
