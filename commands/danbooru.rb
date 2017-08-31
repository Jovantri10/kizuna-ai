module Aichan
    require_relative '../helpers/danbooru.rb'
    require_relative '../helpers/suggest_tag.rb'

    #Get a random file from danbooru (Also see :safebooru)
    Aichan::BOT.command :danbooru, help_available:false, description: 'get a random image from danbooru for a given tag (character, series, etc.) that may or may not be remotely sfw', usage: "#{Aichan::BOT.prefix}danbooru <tag>" do |event, *args|
        #danbooru separates words with underscores, so replace spaces with those
        tag = args.join('_')
        #Try to get an image url
        url = random_pic(tag)
        #If something was found, send the url
        if url != ''
            event.respond(url)
        #Otherswise, try to suggest similar tags
        else
            suggest_tag(tag, event)
        end
    end
end
