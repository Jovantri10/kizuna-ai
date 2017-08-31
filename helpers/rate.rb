#first_second#
$first = ['me', 'my', 'myself', 'i', "i'm", "i'd", "i've", "i'd've", "i'll", 'mine']
$second = ['you', 'your', 'yourself', 'you', "you're", "you'd", "you've", "you'd've", "you'll", 'yours']

#is_self?
#TODO: Move to config.json
$selflist = ['kizuna ai', 'ai-chan', 'kizuna-ai', 'kizuna ai-chan', '<@323238955707269120>', 'the bot', 'ai', 'kizuna']

#$rate
def first_second(phrase)
    #Add a way to avoid the flip
    if phrase[0] == '%'
        return phrase[1..-1]
    end
    #Split the phrase into an array of words
    words = phrase.split(' ')
    #Parse each word (using collect! because it makes it easy to modify any given item
    words.collect! do |word|
        #Note if a word is being greentexted and if the word changes (so the > can be
        #readded later if needed)
        greentext = (word[0] == '>')
        flipped = false

        #Make a variable for the downcased word (we use it a lot)
        word_downcase = word.downcase

        #If a word is first-person, make it second-person
        if $first.index(word_downcase)
            word = $second[$first.index(word_downcase)]
            flipped = true
        #If a word is second-person, make it first-person
        elsif $second.index(word_downcase)
            word = $first[$second.index(word_downcase)]
            if word[0] == 'i'
                word[0] = 'I'
            end
            flipped = true
        #Otherwise, remove punctuation, numbers, etc. and try again
        #(We can't do this from the start because of contractions like I'll and you'll)
        else
            clean_word = word_downcase.gsub(/[^a-z]/, '')
            if $first.index(clean_word)
                word = $second[$first.index(clean_word)]
                flipped = true
            elsif $second.index(clean_word)
                word = $first[$second.index(clean_word)]
                if word[0] == 'i'
                    word[0] = 'I'
                end
            flipped = true
            end
        end
        #If a word initially started with '>' and was first- or second-person, readd the '>'
        if greentext and flipped
            word = '>' + word
        end
        #word will either be the original word (if it didn't need to be changed) or the
        #changed word (if it did). Either way, that's what's going in this position in the
        #array
        word
    end
    #Return the word array as a string
    words.join(' ')
end

#$rate
def is_self?(word)
    #If the word is recognized as a first-person pronoun or the bot's name, return true
    clean_word = word.downcase.gsub(/[^a-z]/, '')
    if $first.include?(clean_word) or $selflist.include?(clean_word)
        return true
    else
        return false
    end
end

