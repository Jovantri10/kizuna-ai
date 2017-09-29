module Aichan
    require_relative '../helpers/xmeme'
    require_relative '../helpers/is_image'

    #Make xmeme directory
    unless Dir.exist? 'xmeme'
        Dir.mkdir 'xmeme'
    end

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
            meme_url = get_xmeme
            if is_image(meme_url)
                event.channel.send_embed do |embed|
                    embed.title = 'Maymay'
                    embed.url = meme_url
                    embed.image = Discordrb::Webhooks::EmbedImage.new url: meme_url
                end
            else
                event.respond meme_url
            end
            #event.respond(get_xmeme)
        end
    end
end
