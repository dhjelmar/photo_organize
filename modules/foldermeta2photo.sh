foldermeta2photo () {

    # pull metadata from current folder through last folder
    # update photo: title
    #               year and month, if needed

    # find all files recursively
    OIFS="$IFS"  # To handle spaces in folders and files: 1st save IFS
    #            # $IFS default is <space><tab<>newline> by default
    IFS=$'\n'    # To handle spaces in folders and files: 2nd change it to focus on new lines
    
    path_files=`find . -type f -name '*.*'`
    
    for path_file in $path_files; do
	dir=`dirname "${path_file}"`
	
	if [ $dir != '.' ]; then
	    
	    echo ------------------------
	    echo $path_file
	    
	    # obtain full directory, but remove current directory, meaning "./"
	    dir="${dir#*/}"
	    dir='2011/2011_03/'

	    # split dir at first letter to know where description starts
	    year='2011'
	    month='03'
	    title='fun in the sun'
	    
	    # update metadata
	    # exiftool "-FileCreateDate<2015:03:05 ${filecreatedate;s/.* //}" "$path_file"
	    #exiftool '-DateTimeOriginal<"'$year:$month:"${DateTimeOriginal;s/[0-9][0-9][0-9][0-9]:[0-9][0-9]://}"'"' "$path_file"
	    filedate=`exiftool -s -s -s -DateTimeOriginal "$path_file"`
	    dhms="${filedate/[0-9][0-9][0-9][0-9]:[0-9][0-9]:/}"
	    newdate="$year:$month:$dhms"
	    exiftool -Title="$title" -alldates="$newdate" "$path_file"

	    
	    #Alternative
	    #   split on "/" into vector
	    #   last vector is file

	    


	    leftovers_from_flatten () {
		# delete function when done with script
		# use sed to replace "/" with "_"
		dir=$(echo "${dir}" | sed s@/@_@g)

		file=`basename "${path_file}"`

		fn="${file%.*}"

		ext=$([[ "$file" = *.* ]] && echo "${file##*.}" || echo '')

		new="${fn}_${dir}.${ext}"	

		echo "dir : $dir"
		echo "file: $file"
		echo "fn  : $fn"
		echo "ext : $ext"
		echo "path_file : $path_file"
		echo "new : $new"
		echo mv \"$path_file\" \"$new\"
		mv "$path_file" "$new"
	    }
	    
	    #echo ------------------------
	fi
    done
    IFS="$OIFS"  # To handle spaces in folders and files: 3rd and last, reset IFS
    return
}
