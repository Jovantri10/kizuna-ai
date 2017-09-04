module Aichan
    #Seekrit help (for aliases and admin commands, since those are the commands where help_available is false)
    Aichan::BOT.command [:secret, :seekrit], help_available: false, description: 'I need assistance', usage: "#{Aichan::BOT.prefix}secret" do |event|
        commands = Aichan::BOT.commands.values.reject do |c|
            c.attributes[:help_available]
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
            embed.add_field(name: "Seekrit commands", value: command_names[0..-4])
            embed.add_field(name: "Other features include", value: ":ok_hand: reacts, :vs: selection, responding to positive or negative statements about the bot, and responding when you scream")
            embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Use #{Aichan::BOT.prefix}help [command name] for more info about a command, or just have fun playing around")
        end
    end
end
