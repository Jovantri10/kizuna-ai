#Get a random number using /dev/urandom
def rando
    urand = File.open('/dev/urandom', 'r')
    retval = urand.read(4).unpack('I')
    urand.close
    retval[0]
end

#puts rando
