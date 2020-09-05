while true; do
    TIME="$(date +'%m/%d | %R')"
    VOLUME="$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }')"

    ARTIST="$(playerctl metadata artist)"
    TRACK="$(playerctl metadata title)"
    POSITION=$(playerctl position | sed 's/..\{6\}$//')
    DURATION=$(playerctl metadata mpris:length | sed 's/.\{6\}$//')
    STATUS="$(playerctl status)"

    if [ "$STATUS" = "Paused" ]; then
        STATUS=" (P)"
    else
        STATUS=""
    fi
    if [ "$STATUS" = "No players found" ]; then
        SPOTIFY=""
    else
        SPOTIFY="$ARTIST - $TRACK $STATUS"
    fi
    SBAR=" $SPOTIFY| $VOLUME V | $TIME "

 #   echo "$SBAR"
    xsetroot -name "$SBAR"
    sleep 1
done
