#! /bin/bash

LOGO="
  NNNNNNNNNNNN                 NNNNNNNNNNNN   
   NNNNNNNNNNNN               NNNNNNNNNNNN    NHentai download script
      NNNNNNNNNN             NNNNNNNNNN       v0.4 - Multithreading, zipping,
         NNNNNN               NNNNNN                 and arguments, oh my!
         NNNNN   N NNNNNN      NNNNN          
        NNNNNNN  NNN    NNN  NNNNNNNN         c4m00 2020
           NNNNNNNN      NNNNNNNN             
                 NN      NN                   
                 NN      NN                   
                 NN      NN                   
                                              "
trap "kill 0" EXIT

# Method to display the usage instructions
usage() {
	echo "Usage:"
	echo "  default: Download a specific link"
	echo "    eg: $0 https://nhentai.net/g/146595/"
	echo "    You can get this ^ URL by right clicking on a doujin/manga"
	echo "    and selecting \"Copy Link Address\""
	echo ""
	echo "  '-s': Search and download by name"
	echo "    eg: $0 -s Love Ridden"
	echo ""
	echo "  '-r': Feeling lucky? Download a random doujin/manga"
	echo "    eg: $0 -r"
	echo ""
	echo "  '-z': Zip the final result"
	echo "    eg: $0 -z -r"
	echo "  '--keep-raw': Keep the original directory with all images inside"
	echo "    eg: $0 -z -r --keep-raw"
}

# If no args
if [[ ! $1 ]]; then
	echo "$LOGO"
	usage
	exit 
fi

RAND=false
ZIP=false
KEEPRAW=false
SEARCH=""

# Handle args
while [ "$1" != "" ]; do
	PARAM=$(echo $1 | awk -F= '{print $1}')
	case $PARAM in
		-r)
			RAND=true
			;;
		-s)
			while [[ "$2" != "" && ! ( "$2" =~ ^-.* ) ]]; do
				SEARCH="$SEARCH $2"
				shift
			done
			;;
		-z)
			ZIP=true
			;;
		--keep-raw)
			KEEPRAW=true
			;;
		*)
			echo "Error: unknown parameter \"$PARAM\""
			usage
			exit 1
			;;
	esac
	shift
done

# Method for spiccy progress bar
# $1 should be amount, $2 should be max
display_progress() {
	PBAR="   ["
	LENGTH=$(($(tput cols)-15))
	AMT=$(($1 * $LENGTH / $2))
	for (( cx=0; cx<$AMT; cx++ )); do
		PBAR="$PBAR \bX"
	done
	for (( cb=1; cb<=$(($LENGTH-$AMT)); cb++ )); do
		PBAR="$PBAR "
	done
	printf "$PBAR] ($1/$2)\r"
}

# Method for spinning
# Should be called in a seperate thread
spinner() {
	ANIM=( "-" "\\" "|" "/" )
	AINDEX=0
	while [[ true ]]; do
		printf " %s\r" "${ANIM[$(($AINDEX % ${#ANIM[@]}))]}"
		AINDEX=$(( $AINDEX + 1 ))
		sleep 0.25
	done
}

# Method that handles downloading of individual images
# Should be called in a seperate thread
# $1 should be the gallery id, $2 should be the image number
# $3 should be 0 be default
download() {
	# Download the image
	curl -s "https://i.nhentai.net/galleries/$1/$2.jpg" -o "$2.jpg"
	# If jpg not available, get a png instead
	if [[ $(stat -c%s "$2.jpg") -lt "256" ]]; then
		if [[ $3 -gt 3 ]]; then
			[[ -f "$2.jpg" ]] && rm "$2.jpg"
			sleep 1
			curl -s "https://i.nhentai.net/galleries/$1/$2.png" -o "$2.png"
		else 
			sleep $(($RANDOM % 5))
			download $1 $2 $(( $3 + 1 ))
		fi
	fi
}

# Search
if [[ $SEARCH != "" ]]; then
	SEARCH="${SEARCH//' '/$'+'}"
	curl -L -s "https://nhentai.net/search/?q=$SEARCH" -o search
	set https://nhentai.net$(cat search | grep -o '/g/.*' | cut -f1 -d'"')
	rm search
fi

# Random
[[ $RAND == true ]] && set https://nhentai.net/random/
		
# Grab the html file for the manga	
curl -L -s "$1" -o html

# Grab key data from the html file
NAME=$(cat html | grep itemprop | grep name | cut -c 33- | rev | cut -c 5- | rev)
GAL=$(cat html | grep itemprop | grep image | cut -c 66- | rev | cut -c 15- | rev)
PAGES=$(cat html | grep "pages</div>" | head -1 | cut -c 10- | rev | cut -c 13- | rev)

echo "Setting up downloaders for $NAME ($GAL)"

# Create a directory for the manga
mkdir "$NAME"
cd "$NAME"

spinner &

# Display initial (empty) progress bar
display_progress 0 $PAGES

# Array for storing thread PIDs
PIDS=()

for ((i = 1; i <= $PAGES; i++)); do
	download $GAL $i 0 &
	PIDS+=( "$!" )
	display_progress $i $PAGES
	sleep 0.01
done

printf "\nDownloading $PAGES pages for $NAME ($GAL)\n"

for i in "${!PIDS[@]}"; do
	display_progress $i $PAGES 
	sleep 0.05
	wait "${PIDS[$i]}"
done

display_progress $PAGES $PAGES

# Zip
if [[ $ZIP == true ]]; then
	printf "\n   Zipping\r"
	zip -q "../$NAME.zip" *
fi

# Go back to original directory and
# delete the temp html file
cd .. && rm html

[[ $ZIP == true && $KEEPRAW == false ]] && rm -rf "$NAME"

printf "\nDone\n"		
