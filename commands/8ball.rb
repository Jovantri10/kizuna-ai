module Aichan
    require_relative '../helpers/8ball.rb'
    #Magic 8ball
    Aichan::BOT.command :"8ball", description: 'You know exactly what this does', usage: "#{Aichan::BOT.prefix}8ball [question]" do |event|
        event.respond("**#{ball_response}**, #{event.user.mention}")
    end

    Aichan::BOT.command :magic8ball, help_available: false, description: 'You know exactly what this does', usage: "#{Aichan::BOT.prefix}8ball [question]" do |event, *args|
        Aichan::BOT.execute_command(:"8ball", event, args)
    end
end
