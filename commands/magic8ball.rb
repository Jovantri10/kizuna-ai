module Aichan
    #$magic8ball
    ball_responses = ["It is certain", "It is decidedly so", "Without a doubt", "Yes definitely", "You may rely on it", "As I see it, yes", "Most likely", "Outlook good", "Yes", "Signs point to yes",
        "Reply hazy try again", "Ask again later", "Better not tell you now", "Cannot predict now", "Concentrate and ask again",
        "Don't count on it", "My reply is no", "My sources say no", "Outlook not so good", "Very doubtful"]

    #Magic 8ball
    Aichan::BOT.command :"8ball", description: 'You know exactly what this does', usage: "#{Aichan::BOT.prefix}8ball [question]" do |event|
        event.respond("**#{ball_responses.sample}**, #{event.user.mention}")
    end

    Aichan::BOT.command :magic8ball, help_available: false, description: 'You know exactly what this does', usage: "#{Aichan::BOT.prefix}8ball [question]" do |event, *args|
        Aichan::BOT.execute_command(:"8ball", event, args)
    end
end
