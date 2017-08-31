module Aichan
    require_relative '../helpers/jsearch'

    #Look up the given word on jisho.org
    Aichan::BOT.command :jisho, description: 'Japanese-english dictionary', usage: "#{Aichan::BOT.prefix}jisho <japanese or english word>" do |event, *args|
        #If they didn't give a word, ask what they want
        if args.length == 0
            event.respond("#{event.user.mention}, what word do you want to look up?")
            break
        end
        #Otherwise, look it up
        results = jsearch(args.join(' '))
        if results.length == 1
            event.respond(results[0])
        else
            result_num = 1
            event.channel.send_embed do |embed|
                embed.title = "results for #{args.join(' ')}"
                embed.color = 4709159
                results.each do |result|
                    embed.add_field(name: "Result #{result_num}", value: result)
                    result_num += 1
                end
            end
        end
    end
end
