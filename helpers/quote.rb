require 'json'
require_relative 'empty'

#The different quote directories
module Pool
    #:aniquote
    ANIMU = "quotes/animu/"
    #:vgquote
    VIDYA = "quotes/vidya/"
    #:normiequote
    GEN = "quotes/general/"
    #:quote
    ALL = "quotes/"
end

#If someone tries to get a quote from pool ALL, one of these is picked at random
$pools = [Pool::ANIMU, Pool::VIDYA, Pool::GEN]

#Add a quote to the given pool
def addquote(quotestring, pool)
    quotelist = quotestring.split('|')
    #If the quote doesn't have the right number of parts, say so
    if quotelist.length < 3
        "That's not a complete quote. `'quote' | 'character' | 'series'`"
    elsif quotelist.length > 3
        "That quote has too many parts. `'quote' | 'character' | 'series'`"
    else #good quote
        #Make a json string representing the quote:
        #{"quote":{"statement":(quote),"character":(source),"series":(extra info)}}
        quotejson = "{\"quote\":{\"statement\":\"#{quotelist[0].strip}\",\"character\":\"#{quotelist[1].strip}\",\"series\":\"#{quotelist[2].strip}\"}}"

        #Save as <first_available_number>.json
        filename = '0.json'
        while File.exist?("#{pool}#{filename}")
            splitname = filename.split('.')
            splitname[0] = (splitname[0].to_i + 1).to_s
            filename = splitname.join('.')
        end

        #Actually write the file
        quotefile = File.open("#{pool}#{filename}", "w")
        quotefile.puts(quotejson)
        quotefile.close
        #Inform the user that their quote was added
        "Quote added!"
    end
end

#Get a random quote from the given pool
def quote(pool)
    #unless the given pool is ALL, in which case another pool is picked at random
    if pool == Pool::ALL
        pool = $pools.sample
    end

    #If there are no quotes in the pool, tell the user
    if empty?(pool)
        return "No quotes of that type"
    end

    #Pick a random file from the given pool
    quotedir = Dir.entries(pool)
    quotefile = "#{pool}#{quotedir[rand(quotedir.length)]}"
    #If we picked a directory, pick again
    while File.directory?(quotefile)
        quotefile = "#{pool}#{quotedir[rand(quotedir.length)]}"
    end
    #debug
    puts quotefile
    #Open the file and get the quote
    readfile = File.open(quotefile, "r")
    quote = JSON.parse(readfile.read)["quote"]
    #Put together the quote (might change how this is done to make the logic less 
    #discord-specific
    retval = ""
    retval += "```\r"
    retval += "\"#{quote["statement"]}\"\r"
    retval += "~#{quote["character"]} (#{quote["series"]})\r"
    retval += "```"
    readfile.close
    #Return the quote
    retval
end

#If any quote pools don't exist, make them
def make_dirs
    unless Dir.exist? Pool::ALL
        Dir.mkdir Pool::ALL
    end
    unless Dir.exist? Pool::GEN
        Dir.mkdir Pool::GEN
    end
    unless Dir.exist? Pool::ANIMU
        Dir.mkdir Pool::ANIMU
    end
    unless Dir.exist? Pool::VIDYA
        Dir.mkdir Pool::VIDYA
    end
end

make_dirs
