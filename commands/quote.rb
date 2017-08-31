module Aichan
    require_relative '../helpers/quote'

    #Add a general quote (see :normiequote) or get a random :aniquote, :normiequote, or :vgquote
    Aichan::BOT.command :quote, description: 'Inspirational quotes', usage: "#{Aichan::BOT.prefix}quote [quote | person | series (or something)]" do |event, *args|
        #If one is being added, try adding it to the general pool
        if args.length > 0
            event.respond("#{addquote(args.join(' '), Pool::GEN)} #{event.user.mention}")
        #Otherwise, get one from a randomly selected pool
        else
            event.respond("#{event.user.mention}\n#{quote(Pool::ALL)}")
        end
    end
end
