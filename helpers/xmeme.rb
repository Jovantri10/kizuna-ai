require_relative 'empty'
require_relative 'is_image'

def add_xmeme(url)
    memepool = Dir.glob("xmeme/*.m")
    memefile = File.open("xmeme/#{memepool.length}.m", "w+")
    memefile.puts(url)
    memefile.close
end

def get_xmeme
    memepool = Dir.glob("xmeme/*.m")
    retval = []
    if memepool.length == 0
        retval.push 'No memes :('
    else
        memefile = File.open("xmeme/#{rand(memepool.length)}.m")
        retval.push memefile.read
        memefile.close
        if is_image(retval[0])
            retval.push 'image'
        end
    end
    retval
end
