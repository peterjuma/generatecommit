#!/bin/bash
default="bin dump trash"

[[ ! -z "$@" ]] && imagename="$@" || imagename=$default

for name in $imagename
	do
		wget https://picsum.photos/500 -O ${name}.jpg
		echo "Downloaded ${name}.jpg ...\n"
		imgcat ${name}.jpg

		git add ${name}.jpg

		echo "![trashimage](${name}.jpg)" >> README.md
done

git add README.md
