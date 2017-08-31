require 'json'
def load_ids(file: "ids.json")
    rfile = File.open(file, 'r')
    data = JSON.parse rfile.read
    rfile.close
    data['data']
end

#TODO: Add config.json file with ids, commands, etc.
def load_config(file: "config.json")
    cfile = File.open(file, 'r')
    data = JSON.parse cfile.read
    cfile.close
    data
end
