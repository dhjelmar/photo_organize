# PICTURE TOOLS
# exiftool to edit picture meta data
# downloaded Linux version of exiftool (on Windows, download Windows version even though run in Git Bash)
# dlh script to use folder names to rename pictures and add metadata tags

alias exiftool='/c/Windows/exiftool.exe'

alias exifclean='exiftool -all= --icc_profile:all --datetimeoriginal'  # -- clean safe meta daat except keeps the icc_profile and datetimeoriginal info

alias exdirclean='rm -r *.jpg_original'

alias exifrestore='exiftool -restore_original'      # "_original" files must be in same folder as edited files

# use exifmark to mark files for possible deletion in digiKam similarity search
alias exifmark='exiftool -r -TagsList="delete_this_if_duplicate"'

#export alltags='-Keywords<Subject -TagsList<Subject -LastKeywordXMP<Subject -CatalogSets<Subject'
export tags='-Keywords<TagsList -Subject<TagsList -LastKeywordXMP<TagsList -CatalogSets<TagsList'
export dates='-FileCreateDate<DateTimeOriginal -FileModifyDate<DateTimeOriginal'

findext () {
    # find all files with given extension but not with "_original" following the extension
    # usage: findext jpg
    find . -name "*.$1" -not -name "*.$1_original*" -type f
}

findorig () {
    # find all files that end with "_original"
    # usage: findorig
    find . -name "*_original" -type f
}

countf () {
    # recursive file count in current directory
    find . -type f | wc -l
}

countd () {
    # recursive file count in current directory
    find . -type d | wc -l
}

rmr () {
    # recursively remove all files that match $1
    # usage: rmr target
    #        rmr "*_original"
    find . -name "$1" -type f -exec rm -f {} \;
    # find . -name "$1" -type f
}

rmd () {
    # recursively empty folders
    # usage: rmorig
    find . -empty -type d -delete
}

files=$git_path'photo_organize/modules/*.sh'
for f in $files; do
    echo "source $f"
    source "$f"
done

# examples
exifex () {
    echo
    echo "# Useful custom environment variables"
    echo "      \$tags = $tags"
    echo "      \$dates= $dates"
    echo
    echo "# To set all metadata needed for digiKam and using DateTimeOriginal for all dates:"
    echo "      exiftool '-alldates<DateTimeOriginal' \$dates                      \\"
    echo "                -Title='my title'                                       \\"
    echo "                -Description='my description'                           \\"
    echo "                -TagsList='my tag' -TagsList='my tag2' \$tags fn.jpg"
    
    ## exiftool -alldates='2004:12:25 13:00:00' $dates -Title='mytitle' -Description='my description' -TagsList='mytag' -TagsList+='mytag2' $tags fn.jpg"
    echo 
    echo "# List metadata"
    echo "exiftool -G -s fn.jpg"
    echo "exiftool -TagsList fn.jpg  # list only Tagslist items from metadata"
    echo
    echo "# Write specific metatdata"
    echo "exiftool -TagsList='mytag' fn.jpg                   # # write a tag"
    echo "exiftool -TagsList='mytag' -TagsList+='joe' fn.jpg  # replace tags, if any, with two tags"
    echo "exiftool -TagsList-='joe' -TagsList+='fred' fn.jpg  # remove tag 'joe' and add tag 'fred'"
    echo
    echo "# Modify dates with AllDates which is equivalent to DateTimeOriginal, CreateDate, and ModifyDate"
    echo "exiftool '-AllDates<DateTimeOriginal' fn.jpg # replace alldates with DateTimeOriginal"
    echo "exiftool $dates fn.jpg                       # replaces system times on files with DateTimeOriginal"
    echo
    echo "exiftool -Title='Christmas 2004' \\"
    echo "         -Description='Brad opens Xbox' \\"
    echo "         -alldates='2004:12:25 13:00:00' \\"
    echo "         -TagLists='Christmas' \\"
    echo "         -tagLists+='tree' \\"
    echo "         fn.jpg"
    echo
    echo "# Useful options:"
    echo "      -r  = recursive"
    echo "      -G  = list metadata family in addition to tagname"
    echo "      -s  = list metadata tagname rather than description of tag"
    echo "      -T  = output metadata to screen in 1 line per file"
    echo "      dir = can specify a directory instead of one or more image files"
    echo
    echo "# Custom functions"
    echo "exifinfo fn.jpg                     # lists a useful selection of metadata for fn.jpg"
    echo "exifdates fn.jpg                    # sets all dates to earliest date in fn.jpg"
    echo "exifdates -d '2024:01:03' fn.jpg    # sets all dates to specified date"
    echo "exiffind 'big red' fn.jpg           # finds all files with 'big red' in FilePath, Title,"
    echo "                                    # TagsList, or RegionName"
}


# ## interesting snippet of code
# IFS='#'
# subject=$(exiftool -s -s -s -E -sep "${IFS}" "-XMP:Subject" "IMG-20230128-WA0000.jpg")
# echo $subject



###################################################################
# none of the following is quite what I want

# https://exiftool.org/forum/index.php?topic=7272.0
# example to grab date from a portion of folder name with dashes in dates
#    exiftool -v -r "-datetimeoriginal<${directory;s/.*(\d{4})-(\d\d)-(\d\d).*/$1:$2:$3/} 00:00:00" .
#
# following do not seem to work
# modified for "_" instead of "-" in folder names
#    alias folderdate='exiftool -v -r "-datetimeoriginal<${directory;s/.*(\d{4})_(\d\d)_(\d\d).*/$1:$2:$3/} 00:00:00"'
# modified to only grab year and month (sets day to 1st of month)
#    alias folderdate='exiftool -v -r "-datetimeoriginal<${directory;s/.*(\d{4})_(\d\d).*/$1:$2/}:01 00:00:00"'

# https://exiftool.org/forum/index.php?topic=5172.0
# exiftool "-datetimeoriginal<${directory;/(\d{4}).(\d{2}).(\d{2})/ ? $_=qq($1:$2:$3 00:00:00) : undef}" FILE
