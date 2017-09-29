# How to configure your kizuna-ai

- `ids`: user IDs and bot token
    - `client_id`: Your bot user's client ID
    - `token`: Your bot user's token
    - `wranglers`: User IDs for any users you think should be allowed to use admin commands like :restart and :die
- `config`: additional settings
    - `default_game`: The bot's "playing" message if someone calls :play without giving the bot something to play
        - Set to "r guilds" to make the default be "(random number) guilds"
        - Replace r with any other single letter to have an accurate guild count
        - Alternatively, set it to anything else for the default to be... whatever you put there
    - `command_dir`: Where to look for command files. Please don't change this unless you know what you're doing
    - `command_whitelist`: Boolean deciding whether to only include commands specified in in `commands` (true) or include all commands except them (false)
    - `commands`: command files to include/exclude (see `command_whitelist`). If left empty, all commands are included regardless of `command_whitelist`
    - `help_color`: Color to use for the :help embed 
    - `familiars`: Bots to let Ai :summon (see commands/summon.rb for more details)  
    - `prefix`: The symbol(s) to put before a command to tell the bot it's a command (so if you keep the default prefix of '$', you would run meme by sending $meme)
