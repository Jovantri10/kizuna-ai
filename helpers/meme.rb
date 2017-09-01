require 'discordrb'
require 'open-uri'
require_relative 'empty'

#Some file extensions to ignore (add more as wanted/needed)
$skiddie = ['exe', 'bat', 'sh', 'jar', 'class', 'js', 'rar', 'zip', 'pdf', 'rb', 'py']

#Pools to grab files from
module Memepool
    #SFW memes
    SAFE = "memes/safe/"
    #Memes that may or may not be SFW
    UNSAFE = "memes/unverified/"
    #Cute/funny animal pics
    ANIMAL = "animals/"
    #All memes
    MEME = "memes/"
    #Images of refusal
    DIE = "no/"
end
#When the MEME pool is requested, one of these is picked at random
$memepools = [Memepool::SAFE, Memepool::UNSAFE]

def add_meme(event, pool)
    if pool == Memepool::MEME
        pool = Memepool::UNSAFE
    end

    event.message.attachments.each do |mem|
        filepath = mem.url.split("/")
        filename = filepath[filepath.length - 1]
        splitname = filename.split('.')
        
        #Unless they're trying to add a bad file, then don't add it
        if $skiddie.include?(splitname[splitname.length-1])
            return 'Nice try skiddie'
        end
        
        #If there's already a file with that name (dumb iPhone posters), add a number to
        #the filename
        if File.exist?("#{pool}#{filename}")
            append = 0
            #Keep incrementing the appended number until there are no filename collisions
            begin
                splitname = filename.split('.')
                splitname[splitname.length - 2] += append.to_s
                testname = splitname.join('.')
                append += 1
            end while File.exist?("#{pool}#{testname}")
            filename = testname
        end

        #Once we find a good file, print the final name (for debugging and in case the 
        #adder wants it removed)
        puts "Final: " + filename
        #Save it
        memefile = File.new("#{pool}#{filename}", "w+")
        memefile.write(open(mem.url).read)
        memefile.close
        #Tell the person their meme has been saved
        return "#{event.user.mention} saved! :ok_hand:"
    end
end

#Get a random file from the given pool
def get_meme(pool)
    #If the given pool is MEME, pick a memepool
    if pool == Memepool::MEME
        pool = $memepools.sample
    end

    #If the pool is dry, don't dive in
    if empty?(pool)
        return 'Nothing to send :('
    end

    #Pick a random file from the given directory
    memes = Dir.entries(pool)
    memefile = "#{pool}#{memes[rand(memes.length)]}"
    #If we picked a directory, pick again
    while File.directory?(memefile)
        memefile = "#{pool}#{memes[rand(memes.length)]}"
    end
    memefile
end

#If any of the pools don't exist, make them
def make_dirs()
    if !Dir.exist? Memepool::MEME
        Dir.mkdir Memepool::MEME
    end
    if !Dir.exist? Memepool::SAFE
        Dir.mkdir Memepool::SAFE
    end
    if !Dir.exist? Memepool::UNSAFE
        Dir.mkdir Memepool::UNSAFE
    end
    if !Dir.exist? Memepool::DIE
        Dir.mkdir Memepool::DIE
    end
    if !Dir.exist? Memepool::ANIMAL
        Dir.mkdir Memepool::ANIMAL
    end
end

make_dirs
