#!/bin/sh
# watch out for a '/' in the parameter
# use alternate search delimiter
sed \
    -e '\_#INCLUDE <'"$1"'>_{
            r '"$1"'
            d
    }' \
    -e '\_#INCLUDE <'"$2"'>_{
            r '"$2"'
            d
    }' \
