#!/bin/bash

PASSWORD="${RANDOM}"
echo "${PASSWORD}"

PASSWORD=$(date +%s)
echo "${PASSWORD}"

#date +%s%N #%s is the seconds and %N is Nanoseconds
#sha256 is used for data integrity #encryption
#head is for selecting first n chars passed into it
#fold to display the input in a wrapped around form
#shuf to perform random permutations
PASSWORD=$(date +%s%n | sha256sum | head -c12)
SPL_CHAR=$(echo '!@#$%&*()_+' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPL_CHAR}"
#for do done

