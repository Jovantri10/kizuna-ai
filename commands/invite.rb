module Aichan
    #Get the bot's invite url
    Aichan::BOT.command :invite, help_available: false do |event|
        event.respond(Aichan::BOT.invite_url)
    end
end
