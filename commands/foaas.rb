module Aichan
    require_relative '../helpers/foaas.rb'

    Aichan::BOT.command :foaas, description: 'Sends any given parameters to foaas.com (see that site for commands; separate parameters with commas)', usage: "#{Aichan::BOT.prefix}foaas <command> [param1, param2, etc.]" do |event, command, *args|
        raw_args = args.join(' ')
        event.respond foaas(command, raw_args.split(', '))
    end
end
