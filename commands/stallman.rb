module Aichan
    #Get the zipped source code for this bot (with a RREADME and tagfile)
    Aichan::BOT.command :stallman, description: 'F R E E D O M', usage: "#{Aichan::BOT.prefix}stallman" do |event|
        #Make a zip file of all code files (with a few additional helpful files) (TODO: link to github if zip command isn't found)
        `zip src *.rb commands/*.rb helpers/*.rb helpers/*.c README.md tags config.json.sample`
        event.channel.send_file File.new('src.zip')
    end

    #See :stallman
    Aichan::BOT.command [:source, :src], help_available: false, description: 'F R E E D O M', usage: "#{Aichan::BOT.prefix}stallman" do |event, *args|
        Aichan::BOT.execute_command(:stallman, event, args)
    end
end
