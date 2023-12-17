#!/bin/bash

getNameFromNumber () {
    printf "%03d" "$1"
}

findFreeFileName () {
    for i in {0..999}; do
        file="$(getNameFromNumber $i)"
        if [[ ! -f "$file" ]]; then
            echo "$file"
            return
        fi
    done
}

writeFile () {
    fileName=$(findFreeFileName)
    echo "$CONTAINER_ID $fileName" > "$fileName"
    echo "$fileName"
}

SLEEP_TIME=1

cd /shared || exit

while true 
do
    if [[ $current ]]; then
        flock -s "$current" -c "rm $current"
        echo "$current is deleted"
        current=""
    else
        current=$(flock -s ".lock" -c "echo $(writeFile)")
        echo "$current is created"
    fi

    sleep $SLEEP_TIME
done
