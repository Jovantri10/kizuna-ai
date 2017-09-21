module Aichan
    require_relative '../helpers/play.rb'
    #Set the bot's "playing" status
    Aichan::BOT.command :play, description: 'Make Ai-chan play a game', usage: "#{Aichan::BOT.prefix}play <game name>" do |event, *args|
        #If nothing was given, use a fallback
        if args.length == 0
            play = CONFIG['default_game']
        else
            play = args.join(' ')
        end
        #See if game should be number of servers
        playing = parse_special(play, Aichan::BOT.servers.length)
        Aichan::BOT.game=playing
    end
end
