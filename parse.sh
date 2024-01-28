#! /usr/bin/env bash

path_file='./2010/2010_08/my title'
echo
echo "$path_file"

# extract first part of path
dir=`dirname "${path_file}"`
echo "dirname                      : $dir"

## remove current directory
# use sed to remove part of string
# ${string#substring}  # removes shortest match of substring from front of $string
# ${string##substring} # removes longest  match of substring from front of $string
# ${string%substring}  # removes shortest match of  substring from back of $string
# ${string%%substring} # removes longest  match of  substring from back of $string
dn="${dir#./}"    # removes "./" from front of $string
dn="${dir#*/}"    # removes up to and including 1st "/" from $string
echo 'dn=${dir#*/}                 : '$dn

# use sed to replace "/" with "."
dnf=$(echo "$dn" | sed s@/@\.@g)                       # e.g., folder1/folder2
echo '$(echo "$dn" | sed s@/@\.@g) : '$dnf

# shorthand replace "/" with "."
# Replace first match of $substring with $replacement
# ${string/substring/replacement}
# Replace all matches of $substring with $replacement
# ${string//substring/replacement}
dnf="${dn//\//\.}"   # repalces all "/" with "."
echo '"${dn//\//\.}"               : '$dnf

# use sed to extract year
# https://tldp.org/LDP/abs/html/string-manipulation.html
# where substring is a regular expression
# expr "$string" : '\($substring\)'   # extracts from beginning of $string
# expr "$string" : '.*\($substring\)' # extracts from end       of $string
year=`expr "$dir" : '.*\([0-9][0-9][0-9][0-9]\)'`
echo 'year                         : '$year

month=`expr "$dir" : '.*\([0-9][0-9]\)'`
echo 'month                        : '$month

# extract last part of path
title=`basename "${path_file}"`
echo "title                        : $title"

# extract parts of fn.ext from basename if it is a file
file=`basename "${path_file}"`
fn="${file%.*}"
ext=$([[ "$file" = *.* ]] && echo "${file##*.}" || echo '')
echo "fn                           : $fn"
echo "ext                          : $ext"

# substring replacement
# Replace first match of $substring with $replacement
# ${string/substring/replacement}

# Replace all matches of $substring with $replacement
# ${string//substring/replacement}
