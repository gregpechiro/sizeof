#!/bin/bash

clear

DIR=`echo ${PWD##*/}`
INCLUDE=("${DIR}" "pub/")

if [ -f "${DIR}.tar" ]; then
	echo "Removing old tar ${DIR}.tar..."
	rm $DIR.tar
fi

echo "Removing old binary ${DIR}..."
go clean
echo "Building ${DIR}..."
go build

if [ ! -f $DIR ]; then
	echo "Build $DIR failed."
	exit 1
fi

echo "Creating tar ${DIR}.tar..."

for item in ${INCLUDE[*]}; do
	TOGETHER="$TOGETHER $item"
done

tar cf $DIR.tar $TOGETHER
if [ ! -f "$DIR.tar" ]; then
	echo "Create $DIR.tar failed."
	exit 1
fi
