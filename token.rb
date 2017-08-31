#Read from the given file
def readfile(filename)
    rfile = File.open(filename, 'r')
    ret = rfile.read
    rfile.close
    ret.strip
end

#Read from the client_id file
def client_id()
    readfile('client_id').to_i
end

#Read from the token file
def token()
    readfile('token')
end

#Read from the wrangler file
def wrangler()
    readfile('wrangler').to_i
end
