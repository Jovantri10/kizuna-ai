module Aichan
    require_relative '../helpers/quote.rb'

    #Get or add an anime quote that really spoke to you
    Aichan::BOT.command :aniquote, description: 'Inspirational weeaboo quotes', usage: "#{Aichan::BOT.prefix}aniquote [quote | character | series]" do |event, *args|
        #If they're trying to add a quote, try to add the quote
        if args.length > 0
            event.respond("#{addquote(args.join(' '), Pool::ANIMU)} #{event.user.mention}")
        #Otherwise, give them a quote
        else
            event.respond("#{event.user.mention}\n#{quote(Pool::ANIMU)}")
        end
    end
    
    #See :aniquote
    Aichan::BOT.command :weebquote, help_available: false, description: 'Inspirational weeaboo quotes', usage: "#{Aichan::BOT.prefix}aniquote [quote | character | series]" do |event, *args|
        Aichan::BOT.execute_command(:aniquote, event, args)
    end
end
