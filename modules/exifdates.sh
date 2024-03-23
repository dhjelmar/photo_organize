exifdates () {
    # dates modify to earliest date in metadata or specified date
    #
    # usage:    exifdates [-d date] fn.jpg
    #           exifdates fn.jpg
    #           exifdates *
    #
    # options:  -d date = "YYYY:mm:dd" sets all dates to specified date
    #                     Not including "-d date" sets all dates to earliest date in metadata
    #
    # examples: exifdates fn.jpg
    #           exifdates -d '1950:12:22' fn.jpg
    #
    # Notes:    Following not writeable: File:FileAccessDate
    #                                    ICC_Profile:ProfileDateTime

    # Default values of arguments
    time=' 00:00:00'
    date=''
    files=()           # () to handle array
    test=
    OIFS="$IFS"  # To handle spaces in folders and files: 1st save IFS
    #            # $IFS default is <space><tab<>newline> by default
    IFS=$'\n'    # To handle spaces in folders and files: 2nd change it to focus on new lines
    
    # Loop through arguments and process them
    while [[ $# -gt 0 ]]; do
	case $1 in
            -d|--date)
		date="$2"
		shift # past argument
		shift # past value
		;;
            -t|--test)
                test="echo"
                shift # past argument
                ;;
            *)
		files+=("$1") # save any remaining arguments in files
		shift # past argument
		;;
	esac
    done

    if [ -z "$date" ]; then
	# no date provided
	echo 'extract oldest time from metatdata for each file'
	config_file=$git_path"set_earliest_date.config"
	
	$test exiftool -config $config_file '-DateTimeOriginal<OldestDateTime'  \
              '-CreateDate<OldestDateTime'                             \
              '-ModifyDate<OldestDateTime'                             \
              '-FileCreateDate<OldestDateTime'                         \
              '-FileModifyDate<OldestDateTime'                         \
              ${files[*]}

    else
	# date provided
	new_time="$date 00:00:00"    # e.g., time='1960:10:23 13:00:00'
	echo 'new time from date specified: '$new_time
	$test exiftool '-DateTimeOriginal="'$new_time'"'  \
              '-CreateDate="'$new_time'"'        \
              '-ModifyDate="'$new_time'"'        \
              '-FileCreateDate="'$new_time'"'    \
              '-FileModifyDate="'$new_time'"'    \
              ${files[*]}
    fi
    IFS="$OIFS"  # To handle spaces in folders and files: 3rd and last, reset IFS
}
