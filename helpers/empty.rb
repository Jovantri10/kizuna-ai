#Used instead of Dir.empty? for the sake of making this bot work on slightly older Ruby versions
def empty?(dirname)
    return Dir.glob("#{dirname}*.*").length == 0
end
