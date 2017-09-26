module Aichan
    require_relative '../helpers/foaas.rb'

    #TODO: make this command more usable
    Aichan::BOT.command :foaas, description: "Sends any given parameters to foaas.com (use #{Aichan::BOT.prefix}foaas operations for a list of commands and parameters)", usage: "#{Aichan::BOT.prefix}foaas <command> [param1, param2, etc.]" do |event, command, *args|
        response = nil
        puts args.length
        if args.length > 0
            raw_args = args.join(' ')
            response = foaas(command, *(raw_args.split(', ')))
        else
            response = foaas(command, *args)
        end
        if response.is_a?(String)
            event.respond response
        else
            event.channel.send_embed do |embed|
                embed.title = "foass help"
                embed.color = CONFIG['help_color']
                embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: Aichan::BOT.profile.avatar_url)
                #commands = []
                response.each do |com|
                    #commands.push(com['url'].split('/')[1])
                    fields = []
                    com['fields'].each do |f|
                        fields.push(f['field'])
                    end
                    fieldstr = ''
                    command = com['url'].split('/')[1]
                    if fields.length > 0
                        fieldstr = fields.join(', ')
                    end
                    embed.add_field(name: com['name'], value: "#{command} #{fieldstr}")
                end
                #embed.add_field(name: "Command list", value: commands.join(', '))
            end
        end
    end
end
