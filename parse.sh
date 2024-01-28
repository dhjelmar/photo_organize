#! /usr/bin/env bash

path_file='./2010/2010_08/my title'
echo
echo "$path_file"

# extract directory
dir=`dirname "${path_file}"`
echo "dirname                     : $dir"

## remove current directory
dn="${dir#*/}"                                        # e.g., ./folder1/folder2
echo 'dn=${dir#*/}                : '$dn

# use sed to replace "/" with "."
dnf=$(echo "$dn" | sed s@/@_@g)                       # e.g., folder1/folder2
echo '$(echo "$dn" | sed s@/@_@g) : '$dnf

# extract name of file (e.g., fn.ex)
file=`basename "${path_file}"`
echo "file                        : $file"

# extract parts of fn.ext
fn="${file%.*}"
ext=$([[ "$file" = *.* ]] && echo "${file##*.}" || echo '')
echo "fn                          : $fn"
echo "ext                         : $ext"
