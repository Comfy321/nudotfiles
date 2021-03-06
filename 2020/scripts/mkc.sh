#! /bin/sh
# Simple script that lets you make files without monotonous typing of "templates".

if [ $# -eq 0 ]
then
    exit 1
fi

FULLNAME=$1
NAME=${FULLNAME%.*}
EXTENSION=${FULLNAME##*.} 
echo $EXTENSION
echo $NAME
touch -f $FULLNAME

TEXTINFILE=""
case $EXTENSION in 
    c) TEXTINFILE=$'#include \"stdio.h\"
int main() {
    return 0;
}'
    ;;
    cpp) TEXTINFILE="#include <iostream>
using namespace std;
int main() {
    return 0;
}"
    ;;
    java) TEXTINFILE="public class $NAME {
    public static void main(String[] args) {
    }
}"
    ;;
    html) TEXTINFILE="<html>
    <head>
        <title>blank</title>
       </head>
    <body>
    </body>
</html>"
        ;;
    *)
        ;;
esac
echo -e "$TEXTINFILE" >> $FULLNAME
exit 0
