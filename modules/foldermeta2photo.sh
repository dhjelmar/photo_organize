foldermeta2photo () {

    modify_title=true
    modify_date=true
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                echo
                echo "Description:"
                echo "     pull metadata from current folder through last folder"
                echo "     update photo: title"
                echo "                   year and month, if needed"
                echo
                echo "Usage: foldermeta2photo [-h] *"
                echo
		echo "Input: folder structure must be YYYY/YYYY_MM/TITLE"
		echo
                echo "Options: -t = do not modify title"
                echo "         -d = do not modify dates"
                echo
                echo "Examples: foldermeta2photo *"
                echo "          foldermeta2photo -d *"
                echo
                return
                ;;
            -t|--title)
                modify_title=false
                shift # past argument
                ;;
            -d|--date)
                modify_date=false
                shift # past argument
                ;;
            *)
                files+=("$1") # save any remaining arguments in files
                shift # past argument
                ;;
        esac
    done

    # find all files recursively
    OIFS="$IFS"  # To handle spaces in folders and files: 1st save IFS
    #            # $IFS default is <space><tab<>newline> by default
    IFS=$'\n'    # To handle spaces in folders and files: 2nd change it to focus on new lines
    
    path_files=`find . -type f -name '*.*'`
    path_files=("$files")
    base=`echo basename $PWD`
    for path_file in $path_files; do
        dir=`dirname "${path_file}"`
        
        echo ------------------------
        echo $path_file
        
        # # obtain full directory, but remove current directory, meaning "./"
        # dir="${dir#*/}"  # e.g., dir='2011/2011_03/my subject'

        # obtain full directory, but replace "./" with name of current directory
        dir="$base/${dir#*/}"  # e.g., dir='2011/2011_03/my subject'
		
        # split full directory into  
        
        # extract last 4 digit # from $path_file for year
        year=`expr "$dir" : '.*\([0-9][0-9][0-9][0-9]\)'`

        # extract last 2 digit # from $path_file for year
        month=`expr "$dir" : '.*\([0-9][0-9]\)'`

        # extract last part of path
        title=`basename "${path_file}"`

        # extract "dd hh:mm:ss" from metadata
        filedate=`exiftool -s -s -s -DateTimeOriginal "$path_file"`
        dhms="${filedate/[0-9][0-9][0-9][0-9]:[0-9][0-9]:/}"
        echo "dhms   : $dhms"
        newdate="$year:$month:$dhms"
        echo "newdate: $newdate"
        
        # update dates with single exiftool call not working
        # exiftool "-FileCreateDate<2015:03:05 ${filecreatedate;s/.* //}" "$path_file"
        #exiftool '-DateTimeOriginal<"'$year:$month:"${DateTimeOriginal;s/[0-9][0-9][0-9][0-9]:[0-9][0-9]://}"'"' "$path_file"
        #exiftool '-DateTimeOriginal<"'$year:$month:"${DateTimeOriginal;s/[0-9][0-9][0-9][0-9]:[0-9][0-9]://}"'"' "$path_file"

        # make changes
        if [ $modify_title = true ]; then $title="'-title=$title'"    ; fi
        if [ $modify_date = true ]; then $date="'-alldates=$newdate'" ; fi
        #exiftool $title $date "$path_file"

        #exiftool -Title="$title" -alldates="$newdate" "$path_file"
        
        #echo ------------------------
    done
    IFS="$OIFS"  # To handle spaces in folders and files: 3rd and last, reset IFS
}
