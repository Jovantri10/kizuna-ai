module Aichan
    #Restart the bot if run by the specified wrangler
    Aichan::BOT.command :restart, help_available: false do |event|
        break unless IDS['wranglers'].include? event.user.id
        event.respond('Restarting')
        Aichan::BOT.stop
        #Starts a new instance of the bot, killing this one.
        exec("ruby robo.rb")
    end
end
