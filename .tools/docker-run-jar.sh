#!/bin/sh

# wrapper to execute something like "jar -cvf ../test.war ." inside a docker container

params="$*"
original="$params"

travers=$(echo "$params" | grep -oP '(\.\.\/)+')
if [ -n "$travers" ]; then
	params=$(echo "$params" | sed 's,'"$travers"',,')
	war=$(echo "$original" | grep -oP "(?<=$travers)[^.]+\.war")
fi

docker run -it --rm -v "$(pwd):/srv" -w /srv -u 1000:1000 java:8-jdk-alpine sh -c "jar $params"

if [ -n "$travers" ] && [ -n "$war" ]; then
	mv "$war" "$travers"
fi
