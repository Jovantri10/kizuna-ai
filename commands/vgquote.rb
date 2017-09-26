module Aichan
    require_relative '../helpers/quote'

    #Get or add a video game quote (also see :aniquote, :normiequote, :quote)
    Aichan::BOT.command :vgquote, description: 'Inspirational vidja gaem quotes', usage: "#{Aichan::BOT.prefix}vgquote [quote | character | game/series]" do |event, *args|
        if args.length > 0
            event.respond("#{addquote(args.join(' '), Pool::VIDYA)} #{event.user.mention}")
        else
            q = quote(Pool::VIDYA)
            event << event.user.mention
            event << '```'
            event << "\"#{q['statement']}\""
            event << "~#{q['character']} (#{q['series']})"
            event << '```'
            #event.respond("#{event.user.mention}\n#{quote(Pool::VIDYA)}")
        end
    end

    #See :vgquote
    Aichan::BOT.command [:vidjaquote, :vidyaquote], help_available: false, description: 'Inspirational vidja gaem quotes', usage: "#{Aichan::BOT.prefix}vgquote [quote | character | game/series]" do |event, *args|
        Aichan::BOT.execute_command(:vgquote, event, args)
    end
end
