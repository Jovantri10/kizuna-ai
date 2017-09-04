require 'discordrb'

module Aichan
    require 'json'
    
    require_relative 'helpers/dangeru'
    require_relative 'config'

    #Seed rng with whatever the OS has
    srand

    config = load_config
    IDS = config['ids']
    CONFIG = config['config']
    BOT = Discordrb::Commands::CommandBot.new token: IDS['token'], client_id: IDS['client_id'], prefix: '$'

    #Load commands:
    #If no specific commands are given, load them all
    if CONFIG['commands'] == nil || CONFIG['commands'].length == 0
        Dir["#{CONFIG['command_dir']}*.rb"].each do |file|
            require_relative file
        end
    #If commands are specified, load them
    else
        #If we're using a command whitelist, include all specified files
        if CONFIG['command_whitelist']
            CONFIG['commands'].each do |file|
                require_relative "#{CONFIG['command_dir']}#{file}" if File.exist? "#{CONFIG['command_dir']}#{file}"
            end
        #If we're not using a whitelist, include all files except the specified one(s)
        else
            Dir["#{CONFIG['command_dir']}*.rb"].each do |file|
                filename = file.split('/')[file.split('/').length - 1]
                cmd = filename.split('.')[0]
                unless CONFIG['commands'].include? cmd
                    require_relative file
                end
            end
        end
    end
    
    #waifu_abuse
    mean_words = ['broken bot', 'bad bot', 'Broken bot', 'Bad bot', 'bot is broken', 'Bot is broken']
    unhappy_reacts = ["I'll try to do better next time", "Hey, fuck off. I'm doing my best here", "You're just jealous because you're not a genius AI like I am", "Stop bullying me!", "You're the broken one here!", "No need to be such a jerk"]
    
    #doing_loving_things_to_your_waifu
    nice_words = ['good bot', 'Good bot', 'nice bot', 'Nice bot', 'like this bot', 'Like this bot', 'bot works', 'Bot works', 'bot werks', 'Bot werks']
    happy_reacts = ["Thank you! Go on, keep saying nice things about me♡", "Of course! I *am* a genius AI, after all", "Thank you ^o^", "Thank you! I might do even better on a better computer though...", "That goes without saying", "Confirmed"]
   
    #Respond if pinged
    BOT.mention do |event|
        if event.message.content.start_with?("#{BOT.prefix}rate") == false
            event.respond('はいどうも！')
        end
    end
    
    #React with ok hand if a message contains the ok hand
    BOT.message(contains: '👌') do |event|
        if event.message.from_bot? == false and event.message.content.include?('🆚') == false
            event.message.create_reaction('👌')
        end
    end
    
    #Pick a winner
    BOT.message(contains: '🆚') do |event|
        if event.message.from_bot? == false
            #split message on :vs:
            combatants = event.message.content.split('🆚')
            #pick winner
            winner = combatants.sample.strip
            #announce winner if she's in a wordposting channel
            if event.channel.name != 'emoji'
                event.respond("The winner is #{winner}")
            end
            #react accordingly
            if winner.length > 2 || winner.match(/[[[:alnum:]][[:punct:]][[:space:]]]/) #server emoji or text (I hope this covers enough of the non-emoji spectrum)
                if winner.byteslice(0) == '<' and winner.byteslice(-1) == '>' #server emoji
                    name = winner.split(':')[1]
                    event.message.create_reaction(BOT.find_emoji(name).to_reaction)
                end
            else #global emoji
                event.message.create_reaction(winner)
            end
        end
    end
    
    #waifu_abuse
    BOT.message(contains: mean_words) do |event|
        event.message.create_reaction('😢')
        event.respond(unhappy_reacts.sample)
    end
    
    #doing_loving_things_to_your_waifu
    BOT.message(contains: nice_words) do |event|
        event.message.create_reaction('😘')
        event.respond(happy_reacts.sample)
    end
    
    #I may need this
    BOT.message(start_with: ['a', 'A']) do |event|
        content = event.message.content.downcase
        content.match(/(a{2,}h*|a+h{2,})/) do |m|
            puts m
            event.respond "You okay there?" if content == m.to_s
        end
    end
    
    #Auto-role new additions to the testing server
    BOT.member_join do |event|
        if event.server.id == 339528771100999682
            new_role = nil
            #Give bots the bot role and humans the human role
            if event.user.bot_account
                new_role = event.server.roles.find{|role| role.name == 'Butt'}
            else
                new_role = event.server.roles.find{|role| role.name == 'Hoomin'}
            end
            event.user.add_role(new_role)
        end
    end
    
    BOT.run
end
