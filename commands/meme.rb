module Aichan
    require_relative '../helpers/meme'

    #Ensure the necessary directories exist
    if !Dir.exist? Memepool::MEME
        Dir.mkdir Memepool::MEME
    end
    if !Dir.exist? Memepool::SAFE
        Dir.mkdir Memepool::SAFE
    end
    if !Dir.exist? Memepool::UNSAFE
        Dir.mkdir Memepool::UNSAFE
    end

    #Get or add a funny picture (or really any sort of file) Also see :safememe
    Aichan::BOT.command :meme, description: 'get a random meme (or add any attached to the message)', usage: "#{Aichan::BOT.prefix}meme [add]" do |event, *args|
        #If they're trying to add something without attaching anything, gently remind them
        #that they need to give a file to add a file. If they do give a file, add it
        if args.length > 0 and args[0].downcase == 'add'
            if event.message.attachments.length == 0
                event.respond('Add what, you fucking disgrace?')
                return
            else
                event.respond(add_meme(event, Memepool::UNSAFE))
            end
        #If they're not adding one, give them one
        else #not adding a maymay
            memefile = get_meme(Memepool::MEME)
            if File.exist? memefile
                event.channel.send_file File.new(memefile)
            else
                event.respond memefile
            end
        end
        nil
    end

    #See :meme
    Aichan::BOT.command :maymay, help_available: false, description: 'get a random meme (or add any attached to the message)', usage: "#{Aichan::BOT.prefix}meme [add]" do |event, *args|
        Aichan::BOT.execute_command(:meme, event, args)
    end
end
