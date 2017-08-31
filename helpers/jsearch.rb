require 'ruby_jisho'
require 'json'

#Search jisho for a given word or phrase
def jsearch(searchstr)
    results = RubyJisho.search(searchstr)
    #If there were no results, say so
    if results.data.length == 0
        return ["Even I couldn't find anything"]
    end
    #If there were results, send back the first three
    left = 3
    retval = []
    results.data.each do |result|
        current = ""
        result[:japanese].each do |jp|
            current += ">#{jp[:word]} (#{jp[:reading]})\r"
        end
        result[:senses].each do |en|
            if en[:english_definitions]
                en[:english_definitions].each do |defn|
                    current += "  >#{defn}\r"
                end
            end
            if en[:links]
                en[:links].each do |wiki|
                    current += "    >#{wiki[:text]}: #{wiki[:url]}\r"
                end
            end
        end
        retval.push(current)
        left = left - 1
        if left == 0
            break
        end
    end
    retval
end

#Save a search to a file (useful for making :startup not query the jisho api each time)
def save_tag(searchstr, page=1)
    #debug
    puts page
    #Do the search
    results = RubyJisho.search("#{searchstr}&page=#{page}")
    #If there are results, add all english definitions to the file
    if results.data.length > 0
        tagfile = File.open(searchstr.gsub(/[[[:punct:]][[:digit:]]]/, ''), "w")
        results.data.each do |result|
            result[:senses].each do |en|
                en[:english_definitions].each do |defn|
                    tagfile.puts defn
                end
            end
        end
        tagfile.close
        #If there were results and we haven't hit page 100 yet, keep going (after waiting
        #5 seconds so we're not just spamming jisho with api requests)
        if page < 100
            puts "next page"
            sleep 5
            save_tag(searchstr, page + 1)
        end
    end
end

#Get a random English* word from a given part of speech tag
#*Sometimes Romaji sneaks into the English definitions
def random_from_jisho(searchstr)
    #Get a random page of results for that part of speech
    results = RubyJisho.search("%23#{searchstr}&page=#{(rand(200)) + 1}")
    #Get a random Enlgish definition for a random sense of a random word
    entry = results.data[rand(results.data.length)]
    sense = entry[:senses][rand(entry[:senses].length)]
    english = sense[:english_definitions][rand(sense[:english_definitions].length)]
    english
end

#Uncomment to save Nouns and/or adjectives to text files (which will then be used by 
#:startup)
#save_tag("%23adjective")
#save_tag("%23noun")
