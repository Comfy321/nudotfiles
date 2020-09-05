wget -nv $1
PAGES=$(cat index.html | grep pages | head -1 | cut -f 1 -d ' ' | cut -c 10- )
TITLE=$(cat index.html | grep "<meta itemprop=\"name\" content=\"" | sed 's/^.*\(content=\".*\"\).*$/\1/' | cut -c 10- | sed 's/.$//')
ID=$(cat index.html | grep "<meta itemprop=\"image\" content=" | grep -o -P '(?<=content="https://t).*(?=/cover)')
mkdir "$TITLE"
cd "$TITLE"
for i in $(seq 1 $PAGES)
    do wget -nv https://i$ID/$i.jpg
    done

cd ..
rm index.html
