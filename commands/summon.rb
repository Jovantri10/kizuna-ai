module Aichan
    require_relative '../helpers/summon'
    $summons = {}

    Aichan::BOT.command :summon, help_available: false, description: 'Summon another bot', usage: "#{Aichan::BOT.prefix}summon <ruby | dorothy>", min_args: 0, max_args: 1 do |event, name|
        return event.respond "Who am I summoning?" unless name
        low_name = name.downcase
        return event.respond "Who is #{name}?" unless File.exist?("#{low_name}.sh")
        return event.respond "#{name} is already running" if $summons[low_name]
        bot_proc = IO.popen("./#{low_name}.sh")
        $summons[low_name] = Familiar.new(low_name, event.user.id, bot_proc)
        event.respond "Successfully started #{name}"
    end

    Aichan::BOT.command :unsummon, help_available: false, description: 'Kill another bot', usage: "#{Aichan::BOT.prefix}unsummon <ruby | dorothy>", min_args: 0, max_args: 1 do |event, name|
        return event.respond "Who am I ~~killing~~ unsummoning?" unless name
        return event.respond "There's no one to ~~kill~~ unsummon" if $summons.length < 1
        low_name = name.downcase
        return event.respond "I can't unsummon anyone I haven't summoned" unless $summons[low_name]
        return event.respond "Please ask a wrangler or whoever summoned #{name} to do this" unless event.user.id == $summons[low_name].summoner || IDS['wranglers'].include?(event.user.id)
        tsukaima = CONFIG['familiars'][low_name]
        tsukaima_user = Aichan::BOT.user(tsukaima['id'])
        if tsukaima_user.on(event.server).permission?(:read_messages, event.channel)
            event.respond(tsukaima['kill'])
        else
            #find a common channel
            event.server.channels.each do |c|
                if Aichan::BOT.profile.on(event.server).permission?(:send_messages, c) && tsukaima_user.on(event.server).permission?(:read_messages, c)
                    Aichan::BOT.send_message(c, tsukaima['kill'])
                    break
                end
            end
        end
        sleep(1)
        if tsukaima_user.status == :offline
            $summons.delete(low_name)
            event.respond "~~Brutally murdered~~ Successfully unsummoned #{name}"
        else
            event.respond "Not dead yet. Try again?"
        end
    end
end
