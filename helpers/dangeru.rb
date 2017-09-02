require 'json'
require 'open-uri'
require 'cgi'

#Parse a danger/u/ thread url for some information, then query the API for a bit more
def get_info(url)
    #Make a map to hold this info
    thread_info = {}
    #Get the url, board name, and thread id from the url
    thread_info[:url] = url
    split_url = url.split('/')
    thread_info[:board] = split_url[split_url.index('dangeru.us') + 1]
    thread_info[:id] = split_url[-1]
    #Use the board name and thread id to query the API for the title and first post
    thread = fetch_info(thread_info[:board], thread_info[:id])
    #title and first post
    thread_info[:title] = thread['meta'][0]['title']
    thread_info[:op] = thread['replies'][0]['post']
    #Return the map
    return thread_info
end

#Query the danger/u/ API for thread details
def fetch_info(board, thread_id)
    #make api request (ln=1)
    json_info = open("https://boards.dangeru.us/api.php?type=thread&board=#{board}&thread=#{thread_id}&ln=1").read.gsub(/[\n\r]/, ' ')
    cleansed_info = CGI::unescapeHTML(CGI::unescapeHTML(json_info))
    #may as well parse json here
    #return result
    JSON.parse(cleansed_info)
end

#Some tests
#test = get_info("https://boards.dangeru.us/u/thread.php?=7772")
#puts "Title: #{test[:title]}"
#puts "OP: #{test[:op]}"
#puts "board: #{test[:board]}"
