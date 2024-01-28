# WORK IN PROGRESS



exifmeta () {

    # Default values of arguments
    time=''
    date=''
    title=''
    description=''
    tagsslist=''
    files=()           # () to initialize array
    test=
    add=

    # Loop through arguments and process them
    while [[ $# -gt 0 ]]; do
        case $1 in
	    -h|--help)
		echo "Adds meta data to file(s) for:"
                echo "   Title"
		echo "   Date = AllDates, FileCreateDate, FileModifyDate"
		echo "   Description"
		echo "   Tags = "$tags
		echo
		echo "Usage:   "
		echo
		echo "Options"
		#          -d = DateTimeOriginal <-- grab from picture name if follows simple convention
		#                                    (e.g., PXL_20230731_132712681.jpg)
		#                                    use YYYY_mm_01 if different from folder structure
		#                                    use YYYY_01_01 if there is no YYY_mm folder
		#          -T = Title            <-- leave blank if no Title folder (needs to contain [a-zA-Z])
		#          -t = TagsList         <-- leave blank if no text in subject
		#                                    (i.e., not just IMG or PXL followed by numbers;
		#                                     e.g., not just PXL_20230731_132712681.jpg)
		#                                    -s also sets metadata: Keywords, TagsList, LastKeywordXMP, CatalogSets
		#          -n = Description
		#
		# options: -a    = adds to tags if used (default is to replace tags)
		#          -r    = remove specified tag
		#          -test = does a dry run showing the exiftool command to be executed
                shift # past argument
                ;;
	    -a|--add)
                add="+"
                shift # past argument
                ;;
            -r|--remove)
                add="-"
                shift # past argument
                ;;
            -d|--date)
                date="$2"
                hour=' 00:00:00'
                time="-AllDates='$date$hour' -FileCreateDate<DateTimeOriginal -FileModifyDate<DateTimeOriginal"
                shift # past argument
                shift # past value
                ;;
            -T|--Title)
                title="-Title='$2'"
                shift # past argument
                shift # past value
                ;;
            -n|--Description)
                description="-Description='$2'"
                shift # past argument
                shift # past value
                ;;
            -t|--TagsList)
		# need to add logic for multiple subject tags to make something like:
		#   -Subject='sub1' -Subject+='sub2'
                # subject="-Subject$add='$2'"
                # Keywords="-Keywords<Subject"
                # TagsList="-TagsList<Subject"
                # LastKeywordXMP="-LastKeywordXMP<Subject"
                # CatalogSets="-CatalogSets<Subject"
		alltags='-Keywords<TagsList -Subject<TagsList -LastKeywordXMP<TagsList -CatalogSets<TagsList'
                tags="-TagsList$add='$2' $alltags"
                shift # past argument
                shift # past value
                ;;
            -test)
                test="echo"
                shift # past argument
                ;;
            *)
                files+=("$1") # save any remaining arguments in files
                shift # past argument
                ;;
        esac
    done

    echo ""
    echo "before changes"
    exiftool -G -s -Title \
                   -alldates \
                   -Description \
                   -Subject \
                   -Keywords \
                   -TagsList \
                   -LastKeywordXMP \
                   -CatalogSets \
                   ${files[*]}

    echo ""
    echo "Date       : "$date
    echo "Time       : "$time
    echo "Title      : "$title
    echo "Description: "$description
    echo "TagsList   : "$tags
    echo "File(s)    : ${files[*]}"
    echo "# of files : ${#files[*]}"
    echo "test       : $test"

    if [ "$test" = "echo" ]; then
        echo ""
        echo "do not make changes"
        
    else
        echo ""
        echo "make changes"
    fi

    $test exiftool $time $title $description $tags ${files[*]}

    if [ "$test" != "echo" ]; then
        echo ""
        echo "after changes"
        exiftool -G -s -Title \
                       -alldates \
                       -Description \
                       -Subject \
                       -Keywords \
                       -TagsList \
                       -LastKeywordXMP \
                       -CatalogSets \
                       ${files[*]}
    fi
}
