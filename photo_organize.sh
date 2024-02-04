#! /usr/bin/env bash

## 

## permission: chmod 755 photo_organize.sh
## execute with: ./photo_organize.sh

# identify current folder
pwd=$PWD

## find relative paths to jpg files
## files=`find . -print | grep -i .jpg`
files=`find . -type f -name "*.jpg"`
## the following is possibly better to find all images (i.e., not just jpg)
## taken from https://stackoverflow.com/questions/16758105/list-all-graphic-image-files-with-find
files=`find . -type f -print0 | xargs -0 file --mime-type | grep -F 'image/' | cut -d ':' -f 1`
#echo $files

# need to first fix to handle spaces in folder names
# temporarily replace $IFS variable which, by default, sets a space to a field delimiter
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

i=0
# loop through each jpg file
for file in ${files}
do

    # start in pwd folder
    cd $pwd

    i=$((i+1))
    echo ' '
    echo 'jpg #' $i ': ' $file
    
    # extract picture name
    picture=`basename "$file"`
    echo "picture       =" $picture

    # extract folder
    ## local folder_file=`dirname $file`  # relative path
    folder=`echo "$file" | sed 1,1s/$picture//`
    echo "folder        =" $folder

    # replace all spaces with _ (no change to actual folder name)
    folder_nospace=`echo "$folder" | sed 1,1s/" "/_/g`
    echo "folder_nospace=" $folder_nospace

    # find deepest (subject1) folder (no spaces)
    subject1=`echo $folder_nospace | awk -F '/' '{print $(NF-1)}'`
    echo "subject1          =" $subject1
    
    # find 2nd deepest (subject2) folder (no spaces)
    subject2=`echo $folder_nospace | awk -F '/' '{print $(NF-2)}'`
    echo "subject2          =" $subject2
    
    # find 3rd deepest (subject3) folder (no spaces)
    subject3=`echo $folder_nospace | awk -F '/' '{print $(NF-3)}'`
    echo "subject3          =" $subject3


    [[ "$subject3"  =~ [a-zA-Z] ]] && echo "contains letters"

    
    #####################################################################
    # need to add coding to:
    #    - test subject1, subject2, and subject3
    #    - extract date if available and descriptive text if available
    #    - extract dates from metadata
    #    - test for descriptive text in metadata
    #    - construct new file name and metadata
    #####################################################################
    
    # enter folder
    cd ${folder}

    # construct new filename
    fn=$subject2"_"$subject1"_"$picture
    fn=`echo $fn | awk -F '/' '{print $(NF-1)}'`
    echo "new filename, fn =" $fn

    ### strip out initial part of folder name
    ### strip='\/f\/MY_PICTURES\/'
    #strip='\.\/'
    #prefix=`echo "$folder_nospace" | sed 1,1s/$strip//`
    #
    ## replace / with _
    #strip='\/'
    #prefix=`echo "$prefix" | sed 1,1s/$strip/_/g`
    #echo "prefix        =" $prefix
    #
    ## construct new filename and eliminate spaces
    #picture_new=$prefix"_"$picture
    #picture_new=`echo $picture_new | awk -F '/' '{print $(NF-1)}'`
    #echo "picture_new   =" $picture_new

    # determine new picture name
    old="$folder$picture"
    new="$folder$fn"
    echo 'old name: ' $old
    echo 'new name: ' $new

    # make the changes
    #cp "$old" "$old"'_original'
    #mv "$old" "$new"

    # options for tags
    # https://www.exiftool.org/TagNames/XMP.html#dc
    #
    # Based on F:\MY Pictures\2010s\2017\2017_04\Dad's service\2010_Thanksgiving whole fam.jpg,
    # Jackie and Dave seem to use:
    #       XMP Title       to identify, e.g., Thanksgiving
    #       XMP Subject     to create tags for people
    # subject is found in "Tags" in File Explorer
    #
    # https://exiftool.org/gui/articles/where_what.html
    #    XMP-dc -for your name, copyright notice, photo title, keywords, etc.
    #    XMP-iptcCore -for your contact data (address, mail, phone, etc.)
    #    XMP-iptcExt -for location data, event notice, names of persons on photo, etc.
    #
    # exiftool -xmp-dc:title="mytitle" -xmp-dc:description="mydescription" -xmp-dc:subject="subject1" -xmp-dc:subject="subject2" test.jpg
    #
    # tried following which loads but Diffractor does not filter on these (MS Photos only uses file name)
    # exiftool -xmp-iptcExt:PersonInImage='David Hjelmar' -xmp-iptcExt:PersonInImage='Brad Hjelmar' test.jpg
    #exiftool -xmp-dc:title="$prefix" -xmp-dc:description="$prefix" -xmp-dc:subject="$subject3" -xmp-dc:subject="$subject2" -xmp-dc:subject="subject1" test.jpg

done

### return vetor from path split by '/' delimeter
#filev=(${file//jpg/ })
#echo ${filev[0]}
#echo ${filev[1]}

### print each file name
#for i in seq 1 1 $filenum
#do
#  echo 'jpg #' $i': ' ${filev[$i]}
#done

## loop through each jpg file
#for i in $(echo $files | tr "jpg" "\n")
#do
#  echo 'jpg #' $i': ' ${filev[$i]}
#done



# ## find number of parts to path
# filenum=(${#pathv[@]})
# echo '# of parts to path ' $filenum



## add entire path to EXIF meta data
#exiftool xxxxxxxxxxxxxxxxxxx

echo '-------------------------'

## if only wanted to grab the 2nd part of the variable, could use the following
#file=`echo ${path} | cut -d '/' -f $filenum`
#echo $file


## add last part of the path to the end of the filename
#mv xx xx


#######################################################

## pull all dates from meta data


## pull date from file path


## if original date exists, set all dates equal to that


## if no original date, look for any date that matches the folder name year and month.
## set all dates to that date.


## if no match, set all dates to the 1st of the month and year of the folder name

cd $pwd

## return file spaces to behave as they did originally
IFS=$SAVEIFS

exit
