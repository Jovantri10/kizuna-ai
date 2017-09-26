#TODO: combine with danbooru
#TODO: remove discordrb dependency
require 'discordrb'
require_relative 'danbooru'
#$safebooru, $danbooru
#Try to find similar tags to the one that was tried
def suggest_tag(attempt, event)
    #If this is being called, there were no results
    event << "I couldn't find anything for `#{attempt}`."
    #If the user was trying multiple tags, let them know what the issue could be
    if attempt.include?("+")
        event << "Either one of those tags doesn't real, or there's no overlap"
        return
    end
    #If they only tried one tag, try to suggest similar tags
    possible_tags = tag_search(attempt)
    if possible_tags.length > 0
        suggestions = ""
        possible_tags.each do |possibility|
            suggestions += "`>#{possibility["name"]}`\r"
        end
        event.channel.start_typing
        event.channel.send_embed do |embed|
            embed.title = "Did you mean one of these?"
            embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: random_safe_pic(possible_tags[0]["name"]))
            embed.add_field(name: "Possible tags", value: suggestions)
        end
    #If no similar tags were found, give up
    else
        event << "In fact, I'm not even sure what tag you're looking for."
    end
    nil
end
