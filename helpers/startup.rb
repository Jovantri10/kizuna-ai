require_relative 'jsearch'

#Some successful products to compare our idea to
$successes = ['Uber', 'Facebook', 'Twitter', 'Google', '4chan', 'Youtube', 'Buzzfeed', 'Reddit', 'Discord', 'Skype', 'Snapchat', 'Wikipedia', 'Airbnb', 'Pinterest', 'Paypal', 'Yelp', 'Tinder', 'Pornhub', 'Powerpoint']

#Pick a random successful product
def success()
    $successes.sample
end

#Pick a random word from a given file
def random_from_file(part_of_speech)
    words = []
    word_file = File.open(part_of_speech)
    word_file.each_line do |current|
        words.push(current)
    end
    word_file.close
    words[rand(words.length)]
end

#Pick a random word (from a file if one exists, from jisho otherwise)
def random_word(part_of_speech)
    if File.exist?(part_of_speech)
        random_from_file(part_of_speech).strip
    else
        random_from_jisho(part_of_speech).strip
    end
end

#Pick a random noun and maybe adjective
def purpose()
    #Decide whether we need an adjective or not
    num_purposes = rand(2)
    purposes = []
    #Get an adjective if we want
    if num_purposes > 0
        purposes.push(random_word("adjective").downcase)
    end
    #Get a noun regardless
    purposes.push(random_word("noun").downcase)
    purposes.join(" ")
end

#Make our big idea
def generate_idea()
    "Like #{success}, but for #{purpose}"
end

#puts generate_idea
