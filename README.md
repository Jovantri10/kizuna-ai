# kizuna-ai

A general command bot for Discord (self-host)

# Requirements to run

- A working internet connection  
- A Discord bot user  
- config.json set up (see config.json.sample)  
- Ruby 2.x with the following gems:  
    - Discordrb  
    - RubyJisho (for jisho and startup)  
- A C Compiler (for helpers/rate.c, which is used by rate and odds)  
- The following installed and in your system path:  
    - fortune (fortune)  
- a server emoji called "honk" (honk)  
  
If you don't meet any of these requirements (other than the first 5 (internet-discordrb), which are all pretty essential), set up config.json to exclude the commands that rely on them (indicated in parentheses; see config.json.sample for more details)  
  
One you're good to go, start the bot by running `ruby robo.rb`
