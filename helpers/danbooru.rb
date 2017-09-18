require 'json'
require 'open-uri'

#All calls will be to danbooru
$base_url = "http://danbooru.donmai.us"

#Search for sfw images in the given tag (I don't think this is used anymore)
#def danbooru_safe_search(tag)
    #tag_str = "rating:safe+#{tag}".gsub(' ', '_')
    #danbooru_search(tag_str)
#end

#Search for any images in the given tag(s)
def danbooru_search(tag_str)
    #Get search results (but only the first 100 to make things easier for everyone involved)
    json_response = open("#{$base_url}/posts.json?limit=100&tags=#{tag_str}").read
    JSON.parse(json_response)
end

#Search for sfw images in a given tag, pick one random pic from there
def random_safe_pic(tag)
    tag_str = "rating:safe+#{tag}".gsub(' ', '_')
    random_pic(tag_str)
end

#Search the given tag(s), choose a pic at random from there
def random_pic(tagstr)
    all_results = danbooru_search(tagstr)
    #If we actually got results, pick one at random
    if all_results.length > 0
        desired_result = rand(all_results.length)
        #If we picked a result without a large_file_url, try again
        while all_results[desired_result]['large_file_url'] == nil || all_results[desired_result]['large_file_url'] == ""
            desired_result = rand(all_results.length)
        end
        #"#{$base_url}#{all_results[desired_result]['large_file_url']}"
        ["#{$base_url}#{all_results[desired_result]['large_file_url']}", "#{$base_url}/posts/#{all_results[desired_result]['id']}"]
    #If there were no results, return an empty string
    else
        ""
    end
end

#Try to find similar tags
def tag_search(attempt)
    #Limit it to the 7 tags with the most posts (these have the best chance of being right)
    args = "search[order]=count&limit=7"
    flipped = attempt.split("_").reverse.join("_")
    #See if they missed anything at the beginning or end (ex. love_live instead of 
    #love_live!)
    close_tags_json = open("#{$base_url}/tags.json?search[name_matches]=*#{attempt}*&#{args}").read
    #See if they used Western name order (ex. rohan_kishibe instead of kishibe_rohan)
    flipped_tag_json = open("#{$base_url}/tags.json?search[name_matches]=#{flipped}&limit=1").read
    #Parse the sets of results, combine them into one array
    close_tags = JSON.parse(close_tags_json) + JSON.parse(flipped_tag_json)
end

##Some tests
#m = safe_search("kudou mirei")
#puts m[0]['large_file_url']
#puts random_safe_pic('kudou mirei')
