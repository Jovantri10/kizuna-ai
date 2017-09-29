module Aichan
    require_relative '../helpers/meme'

    #Ensure the necessary directory exists
    if !Dir.exist? Memepool::ANIMAL
        Dir.mkdir Memepool::ANIMAL
    end

    #Get or add a cute/funny animal pic
    Aichan::BOT.command :animal, description: 'Aww', usage: "#{Aichan::BOT.prefix}animal [add]" do |event, *args|
        #If they're adding an animal and attached a pic, add it. If they didn't include
        #a pic, ask why there's no attachment
        if args.length > 0 and args[0].downcase == 'add'
            if event.message.attachments.length == 0
                event.respond("Where's the aminal?")
                return
            else
                event.respond(add_meme(event, Memepool::ANIMAL))
            end
        #If they're not adding an animal, send them one
        else #not adding an animal
            event.channel.send_file File.new(get_meme(Memepool::ANIMAL))
        end
        nil
    end
end
