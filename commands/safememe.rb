module Aichan
    require_relative '../helpers/meme'

    #Ensure the necessary directories exist
    if !Dir.exist? Memepool::MEME
        Dir.mkdir Memepool::MEME
    end
    if !Dir.exist? Memepool::SAFE
        Dir.mkdir Memepool::SAFE
    end

    #Get or add a funny sfw pic (also see :meme)
    Aichan::BOT.command :safememe, help_available: false, description: 'get a random sfw meme (or add any attached to the message)', usage: "#{Aichan::BOT.prefix}safememe [add]" do |event, *args|
        if args.length > 0 and args[0].downcase == 'add'
            if event.message.attachments.length == 0
                event.respond('Add what, you big dummy?')
                return
            else
                event.respond(add_meme(event, Memepool::SAFE))
            end
        else #not adding a maymay
            event.channel.send_file File.new(get_meme(Memepool::SAFE))
        end
        nil
    end
end
