module Aichan
    #Sends the first :honk: emoji it finds. Note: this is how I found out bots have 
    #Nitro-esque emoji usage
    Aichan::BOT.command :honk, description: 'Honk', usage: "#{Aichan::BOT.prefix}honk" do |event|
        Aichan::BOT.find_emoji('honk')
    end

    #See :honk (initially intended as a test command)
    Aichan::BOT.command :test, help_available: false, description: 'Honk', usage: "#{Aichan::BOT.prefix}honk" do |event, *args|
        Aichan::BOT.execute_command(:honk, event, args)
    end
end
