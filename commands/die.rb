module Aichan
    require_relative '../helpers/meme'

    #Kill the bot if run by the user specified in the wrangler file
    Aichan::BOT.command [:die, :kill, :stop], help_available: false  do |event|
        #If some random person tries to kill the bot, send them a pic telling them to go away
        #if event.user.id != wrangler
        unless IDS['wranglers'].include? event.user.id
            event.channel.send_file File.new(get_meme(Memepool::DIE))
            return
        end
    
        event.respond('またね！')
        Aichan::BOT.stop
        exit
    end
end
