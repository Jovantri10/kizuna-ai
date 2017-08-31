module Aichan
    require_relative '../helpers/quote'

    #Get or add a quote unrelated to anime or video games. Also see :aniquote, :quote, :vgquote
    Aichan::BOT.command :regquote, description: 'Inspirational quotes', usage: "#{Aichan::BOT.prefix}quote [quote | person | series (or something)]" do |event, *args|
        if args.length > 0
            event.respond("#{addquote(args.join(' '), Pool::GEN)} #{event.user.mention}")
        else
            event.respond("#{event.user.mention}\n#{quote(Pool::GEN)}")
        end
    end
end
