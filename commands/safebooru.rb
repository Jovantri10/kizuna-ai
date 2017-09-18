module Aichan
    require_relative '../helpers/danbooru'
    require_relative '../helpers/suggest_tag'

    #Get a random rating:safe image from danbooru from a given tag (also see :danbooru)
    Aichan::BOT.command :safebooru, description: 'get a random "sfw" image from danbooru, a site with somewhat questionable standards for that rating, for a given tag (character, series, etc.)', usage: "#{Aichan::BOT.prefix}safebooru [tag]" do |event, *args|
        tag = args.join('_')
        url = random_safe_pic(tag)
        if url != ''
            #event.respond "#{url[0]} #{url[1]}"
            #event.respond(url)
            event.channel.send_embed do |embed|
                embed.title = url[2]
                embed.url = url[1]
                embed.image = Discordrb::Webhooks::EmbedImage.new(url: url[0])
            end

        else
            suggest_tag(tag, event)
        end
    end
end
