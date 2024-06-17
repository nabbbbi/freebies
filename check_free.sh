#!/bin/bash

# author: Gadzhiev Ruslan aka nonchlant__orca

LIST="$HOME/programming/projects/freebies/list.txt"

# URLs which I have interested

GOG_URL=https://old.reactor.cc/tag/gog+%D1%85%D0%B0%D0%BB%D1%8F%D0%B2%D0%B0/new
UNITY_URL=https://old.reactor.cc/tag/Unity+%D1%85%D0%B0%D0%BB%D1%8F%D0%B2%D0%B0/new
STEAM_URL=https://old.reactor.cc/tag/%D1%85%D0%B0%D0%BB%D1%8F%D0%B2%D0%B0+steam/new
EPIC_URL=https://old.reactor.cc/tag/EGS+%D1%85%D0%B0%D0%BB%D1%8F%D0%B2%D0%B0/new
FREE_URL=https://old.reactor.cc/tag/%D0%A5%D0%B0%D0%BB%D1%8F%D0%B2%D0%B0/new
KEY_URL=https://old.reactor.cc/tag/%D0%BA%D0%BB%D1%8E%D1%87%D0%B8+%D0%B8+%D0%BA%D1%83%D0%BF%D0%BE%D0%BD%D1%8B+steam/new
# ANON_URL=https://old.reactor.cc/tag/anon/new

GOG=134
UNITY=43
STEAM=2698
EPIC=97
FREE=3658
KEY=48
#ANON=208057

# Creating arrays

POST=("$GOG" "$UNITY" "$STEAM" "$EPIC" "$FREE" "$KEY" "$ANON")
URLS=("$GOG_URL" "$UNITY_URL" "$STEAM_URL" "$EPIC_URL" "$FREE_URL" "$KEY_URL" "$ANON_URL")

# Sed URLS array to newest values

C=0

while read line; do
    POST[$C]=$line
    C=$((C+1))
done < $LIST

I=0
B=TRUE

# Infinite loop

while test $B == "TRUE"; do
    for C in {0..5}; do
	RESULT=`curl --silent ${URLS[$C]} | grep Сообщений | sed 's/>/\n/g' | sed 's/[</>]/ /g' | awk 'NR==2{print $1}'`
	# if original values is not matched with result then launch chromium-browser
	
	if test ${POST[C]} != $RESULT; then
	    # and update original values to output of RESULT
	    
	    POST[$C]=$RESULT
	    > $LIST
# Update the list
	    for N in {0..5}; do
		echo ${POST[$N]} | cat >> $LIST
	    done
	    chromium-browser --new-window ${URLS[C]}
	fi
    done
# Wait a minute
    sleep 60
done
