module Aichan
    require_relative '../helpers/xmeme'
    Aichan::BOT.command :xmeme, description: 'Testing new meme system', usage: "#{Aichan::BOT.prefix}xmeme [add [url]]" do |event, *args|
        if args.length > 0 && args[0].downcase == 'add'
            if event.message.attachments.length > 0
                event.message.attachments.each do |mem|
                    add_xmeme(mem.url)
                end
                event.respond 'Added attached meme(s)'
            elsif args.length > 1
                args[1..-1].each do |url|
                    add_xmeme(url)
                end
                event.respond 'Added meme(s) from url'
            else
                event.respond 'What exactly am I supposed to be adding?'
            end
        else
            event.respond(get_xmeme)
        end
    end
end
