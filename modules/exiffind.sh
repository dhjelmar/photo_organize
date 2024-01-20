exiffind () {
    # find all files with specified tag

    # usage   : exiffind mytag files

    # examples: exiffind exmple *

    tag="$1"
    shift 1         # to move past the 1st argument
    files=("$@")    # to capture remaining arguments in vector
    OIFS="$IFS"  # To handle spaces in folders and files: 1st save IFS
    #            # $IFS default is <space><tab<>newline> by default
    IFS=$'\n'    # To handle spaces in folders and files: 2nd change it to focus on new lines
    
    ## "-Description" tag does not seem to work in following proably because of -T format of output
    exiftool -T -FilePath -Title -TagsList -RegionName ${files[*]} | grep -i $tag

    IFS="$OIFS"  # To handle spaces in folders and files: 3rd and last, reset IFS
}
