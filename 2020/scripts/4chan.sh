#function 4chan() {
    if [[ $# -ne 1 ]]
    then
        echo 'No URL specified! Give the URL to the thread as the ONLY argument'
        return 1
    fi

    # This should look something like: g/thread/73097964
    urlPrimative=$(grep -o '[0-9a-zA-Z]\{1,4\}/thread/[0-9]*' <<< $1)
    
    if [[ -z $urlPrimative ]]
    then
        echo 'Malformed URL! Give the URL to the thread as the ONLY argument'
        return 2
    fi

    threadJSON=$(curl -s https://a.4cdn.org/$urlPrimative.json)

    if [[ -z $threadJSON ]]
    then
        echo 'Invalid URL! It either 404`d or was never a real thread'
        return 3
    fi

    if which jq 2>&1 > /dev/null
    then
        :
    elif which curl 2>&1 > /dev/null
    then
        :
    else
        echo 'jq and/or curl not found! Install jq and curl'
        return 4
    fi

    imageCount=$(echo $threadJSON | jq -r '.posts[] | select(.ext)' | jq -r '"\(.tim)\(.ext)"' | wc -l)
    counter=1

    board=$(cut -f1 -d/ <<< $urlPrimative)

    for imageURL in $(echo $threadJSON | jq -r '.posts[] | select(.ext)' | jq -r '"\(.tim)\(.ext)"' | sed "s/^/https:\/\/i.4cdn.org\/$board\//")
    do
        echo -n Downloading image $counter of $imageCount...
        wget -q -nc $imageURL
        echo ' Done'
        counter=$(($counter + 1))
    done
#}

