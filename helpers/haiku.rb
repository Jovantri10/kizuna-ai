require_relative 'empty'

$haiku_dir = 'haiku/'

#Add a new line (num_syllables error checking is done in commands/haiku.rb, so it should only ever be 5 or 7)
def add_line(num_syllables, line)
    #Get a unique filename (x.y where x is the first available number and y is num_syllables)
    filenum = 0
    filename = "#{$haiku_dir}#{filenum}.#{num_syllables}"
    while File.exist?(filename)
        filenum += 1
        filename = "#{$haiku_dir}#{filenum}.#{num_syllables}"
        puts filename
    end
    #Debug
    puts "Final: #{filename}"
    #Write the line to this new file
    linefile = File.open(filename, 'w+')
    linefile.puts(line)
    linefile.close
    #Report success
    'Line added!'
end

#Get a random haiku
def get_haiku()
    #If there are no lines, we can't make a haiku
    if empty?($haiku_dir)
        return "I don't have enough lines to make a haiku"
    end

    five = Dir.glob("#{$haiku_dir}*.5")
    seven = Dir.glob("#{$haiku_dir}*.7")
    #If we either don't have any 5-syllable lines or don't have any 7-syllable ones, we still can't make a haiku
    if five.length == 0 || seven.length == 0
        return "I don't have enough lines to make a haiku"
    end
    #Get three random lines (5, 7, 5)
    files = [five[rand(five.length)], seven[rand(seven.length)], five[rand(five.length)]]
    retval = ""
    #Read the lines and combine them into one haiku string
    files.each do |line|
       linefile = File.open(line, 'r')
       retval += linefile.read
       linefile.close
    end
    #newline will be included in the file, so just need to trim off the trailing one
    retval[0..-1]
end

#If we don't have a directory for lines to go in, make one
def make_dirs()
    unless Dir.exist?($haiku_dir)
        Dir.mkdir($haiku_dir)
    end
end

make_dirs
