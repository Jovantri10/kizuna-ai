module Aichan
    #Get the zipped source code for this bot (with a RREADME and tagfile)
    Aichan::BOT.command :stallman, description: 'F R E E D O M', usage: "#{Aichan::BOT.prefix}stallman" do |event|
        #Make a zip file of all code files (with a few additional helpful files)
        `zip src *.rb commands/*.rb helpers/*.rb helpers/*.c README.md tags config.json.sample`
        #Send the zip file if it was made, send a github link if it wasn't (like if the bot can't find a zip command)
        if File.exist? src.zip
            event.channel.send_file File.new('src.zip')
        else
            event.respond "Source is available at https://github.com/rholan6/kizuna-ai"
        end
    end

    #See :stallman
    Aichan::BOT.command [:source, :src], help_available: false, description: 'F R E E D O M', usage: "#{Aichan::BOT.prefix}stallman" do |event, *args|
        Aichan::BOT.execute_command(:stallman, event, args)
    end
end
