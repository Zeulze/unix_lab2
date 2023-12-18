#!/bin/bash
getOS () {
    shopt -s nocasematch
    windows=".*windows.*"
    linux=".*linux.*"
    if [[ $OS =~ $windows ]]; then
        echo "windows"
        return
    fi
    if [[ $OS =~ $linux ]]; then
        echo "linux"
        return
    fi
    exit
}

getPWD () {
    if [[ $1 == "windows" ]]; then
        pwd -W
    elif [[ $1 == "linux" ]]; then
        pwd
    fi
}


os=$(getOS)

pwd=$(getPWD "$os")

n=$1
if [[ ! $n ]]; then
    n=1
fi

./clean.sh
for i in $(seq 1 $n)
do
    docker run -v "$pwd/shared":/shared -tid zeu/lab2:latest
done
