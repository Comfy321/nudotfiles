TEXT=$(xclip -o | tr '\n' ' ')

sleep 5

for (( i=0; i<${#TEXT}; i++ )); do
     [ 0 -eq $(($i % 255)) ] && [ $i -ne 0 ] && xdotool click 1
    CHAR="${TEXT:$i:1}"
    case "$CHAR" in
        " ") CHAR="space" ;;
        ":") CHAR="colon" ;;
        "[") CHAR="bracketleft" ;;
        "]") CHAR="bracketright" ;;
        ",") CHAR="comma" ;;
        ";") CHAR="semicolon";;
        '"') CHAR="quotedbl" ;;
        "'") CHAR="apostrophe" ;;
        ".") CHAR="period" ;;
        "!") CHAR="exclam" ;;
        "?") CHAR="question" ;;
        "-") CHAR="minus" ;;
        "(") CHAR="parenleft" ;;
        ")") CHAR="parenright" ;;
    esac
    xdotool key "$CHAR"
done
