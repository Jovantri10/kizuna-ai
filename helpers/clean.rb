#$rate, $odds
#Removes characters that could be used to escape from a bash string
#deprecated
def clean(a_string)
    a_string.gsub(/[\";$`]/, '')
end
