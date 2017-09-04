def parse_special(game, server_count)
    lower_game = game.downcase
    lower_game.match(/[[:alpha:]]{1} guilds/) do |m|
        if lower_game[0] == 'r'
            game = rand(99999999).to_s + game[1..-1]
        else
            game = server_count.to_s + game[1..-1]
        end
    end
    game
end
