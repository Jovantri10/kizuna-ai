module Aichan
    require_relative '../helpers/haiku'

    Aichan::BOT.command :haiku, max_args: 1, description: '5, 7, 5', usage: "#{Aichan::BOT.prefix}haiku [add]" do |event, contribute|
        if !contribute || !contribute.downcase == 'add'
            event.respond(get_haiku)
            return nil
        end
        num_syllables = 0
        event.user.await("#{event.message.id}_syllables".to_sym) do |syllable_event|
            syllables = syllable_event.message.content.downcase
            puts syllables
            if syllables.start_with?('five', '5')
                num_syllables = 5
            elsif syllables.start_with?('seven', '7')
                num_syllables = 7
            else
                num_syllables = -1
                syllable_event.respond "Either I can't understand you or you don't know how haikus work"
            end
        end
        event.respond "Do you want to add a 5-syllable or 7-syllable line?"
        while num_syllables == 0
        end
        if num_syllables > 0
            event.user.await("#{event.message.id}_line".to_sym) do |line_event|
                line = line_event.message.content
                line_event.respond(add_line(num_syllables, line))
            end
            event.respond "What's the line you want to add?"
        end
    end
end
