module Aichan
    #Help me (modified version of discordrb's default help command)
    Aichan::BOT.command :help, max_args: 1, description: 'I need assistance', usage: "#{Aichan::BOT.prefix}help [command]" do |event, command_name|
        if command_name
            command = Aichan::BOT.commands[command_name.to_sym]
            return "I'm not seeing a #{Aichan::BOT.prefix}#{command_name} command" unless command
            description = command.attributes[:description] || 'No description, but it probably does something'
            usage = command.attributes[:usage]
            event.channel.send_embed do |embed|
                embed.title = command_name
                embed.color = CONFIG['help_color']
                embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: Aichan::BOT.profile.avatar_url)
                embed.add_field(name: "Description", value: description)
                embed.add_field(name: "Usage", value: usage)
            end
        else #no command specified
            commands = Aichan::BOT.commands.values.reject do |c|
                !c.attributes[:help_available]
            end
            commands = commands.sort_by!{|c| c.name}
            command_names = ""
            event.channel.send_embed do |embed|
                embed.title = Aichan::BOT.profile.username
                embed.color = CONFIG['help_color']
                embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: Aichan::BOT.profile.avatar_url)
                commands.each do |c|
                    command_names += "#{c.name},  "
                end
                embed.add_field(name: "Command list", value: command_names[0..-4])
                embed.add_field(name: "Other features include", value: ":ok_hand: reacts, :vs: selection, responding to positive or negative statements about the bot, and responding when you scream")
                embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Use #{Aichan::BOT.prefix}help [command name] for more info about a command, or just have fun playing around")
            end
        end
    end
end
