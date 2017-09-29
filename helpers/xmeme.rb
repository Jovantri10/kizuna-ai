require_relative 'empty'

def add_xmeme(url)
    memepool = Dir.glob("xmeme/*.m")
    memefile = File.open("xmeme/#{memepool.length}.m", "w+")
    memefile.puts(url)
    memefile.close
end

def get_xmeme
    memepool = Dir.glob("xmeme/*.m")
    retval = ''
    if memepool.length == 0
        retval = 'No memes :('
    else
        memefile = File.open("xmeme/#{rand(memepool.length)}.m")
        retval = memefile.read
        memefile.close
    end
    retval.strip
end
